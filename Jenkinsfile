node('master') {
    stage('Checkout') {
        checkout scm
    }

    def props = readProperties file: "${WORKSPACE}/job.properties"

    stage('Fucking sonar') {
        withSonarQubeEnv('SonarQube') {
            sh "curl https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip -o sonar-scanner.zip && unzip sonar-scanner.zip"
            sh "ls -r sonar-scanner"
            sh "sonar-scanner/sonar-scanner -Dsonar.projectKey=${props.project} -Dsonar.sources=."
        }
    }

    stage('Standing by') {
        input('The rest probably wont work for now, waiting for a python3 install')
    }

    stage('Tests') {
        sh 'pip install tox'
        sh 'cd app && tox'
    }

    stage('Build') {
        sh 'python setup.py bdist_wheel'
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
