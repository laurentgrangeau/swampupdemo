node('master') {
    stage('Checkout') {
        checkout scm
    }

    def props = readProperties file: "${WORKSPACE}/job.properties"

    stage('Tests') {
        sh 'cd app'
        sh "pip3 install -r ${WORKSPACE}/app/test-requirements.txt"
        sh 'nosetests -v --with-xunit --cover-erase --cover-branches --cover-xml --with-coverage'
    }

    stage('Quality tests') {
        def scannerHome = tool 'SonarqubeScanner';
        withSonarQubeEnv('SonarQube') {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${props.project} \
            -Dsonar.projectVersion='1.0.0' -Dsonar.projectName=${props.project} \
            -Dsonar.sources='app' -Dsonar.host.url=$SONAR_HOST_URL \
            -DfailIfNoTests=false \
            -Dsonar.python.coverage.reportPath=coverage.xml \
            -Dsonar.dynamicAnalysis=reuseReports \
            -Dsonar.core.codeCoveragePlugin=cobertura \
            -Dsonar.python.coverage.forceZeroCoverage=true \
            -Dsonar.python.xunit.reportPath=nosetests.xml \
            -Dsonar.python.xunit.skipDetails=false"
        }
    }

    stage('Build') {
        sh 'rm -rf dist build *.egg-info'
        sh 'python3 app/setup.py bdist_wheel --universal'
    }

    stage('Push') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${props.pypiCreds}",
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sl "ls dist/"
            sh "twine upload --repository-url ${props.pypiRepo} -u ${USERNAME} -p ${PASSWORD} dist/*.whl"
        }
    }

    stage('Deploy') {
        sh "docker build -t ${props.project} ."
        sh "docker run -dp 8080:8080 ${props.project}"
    }
}
