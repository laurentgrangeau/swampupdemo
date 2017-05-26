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
        sh 'rm -rf app/dist app/build app/*.egg-info'
        sh 'cd app; python3 setup.py bdist_wheel --universal --python-tag py3'
    }

    stage('Push') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${props.pypiCreds}",
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sh "twine upload --repository-url ${props.pypiRepo} -u ${USERNAME} -p ${PASSWORD} app/dist/*.whl"
        }
    }

    stage('Deploy') {
        sh "docker build -t ${props.project} --build-arg project=${props.project}  . --no-cache"
        try {
            sh "docker service create --publish ${props.port}:8080 --name ${props.project} ${props.project}"
        } catch (error) {
            sh "docker service update --image ${props.project} ${props.project}"
        }
    }
}
