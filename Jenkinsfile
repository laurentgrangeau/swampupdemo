node('master') {
    stage('Checkout') {
        checkout scm
    }

    def props = readProperties file: "${WORKSPACE}/job.properties"

    stage('Tests') {
    withEnv(["PATH+PYTHON=~/miniconda/bin"]) {
            sh 'cd app'
            sh 'nosetests -v --with-xunit --cover-erase --cover-branches --cover-xml --with-coverage'
        }
    }

    stage('Quality tests') {
        def scannerHome = tool 'SonarqubeScanner';
        withSonarQubeEnv('SonarQube') {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${props.project} \
            -Dsonar.projectVersion='1.0.0' -Dsonar.projectName=${props.project} \
            -Dsonar.sources='app' -Dsonar.host.url=$SONAR_HOST_URL \
            -Dsonar.jdbc.url=$SONAR_JDBC_URL -Dsonar.jdbc.username='$SONAR_JDBC_USERNAME' \
            -Dsonar.jdbc.password=$SONAR_JDBC_PASSWORD -DfailIfNoTests=false \
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
        withEnv(["PATH+PYTHON=~/miniconda/bin"]) {
            sh 'python setup.py bdist_wheel'
        }
    }

    stage('Push') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${props.pypi-creds}",
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sh "twine upload -r ${props.pypi-repo} -u ${USERNAME} -p ${PASSWORD}"
        }
    }

    stage('Deploy') {
        sh "echo 'Donde esta la bibliotheca ?'"
    }
}
