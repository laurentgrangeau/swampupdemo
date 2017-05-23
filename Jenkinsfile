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
            -Dsonar.python.xunit.skipDetails=false \
            -Dsonar.verbose=true "
        }
    }

    stage('Build') {
        sh 'python3 app/setup.py bdist_wheel'
    }

    stage('Push') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${props.pypiCreds}",
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sh "twine upload -r ${props.pypiRepo} -u ${USERNAME} -p ${PASSWORD} app/dist/*"
        }
    }

    stage('Deploy') {
        sh "echo 'Donde esta la bibliotheca ?'"
    }
}
