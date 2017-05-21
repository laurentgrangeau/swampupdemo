node('master') {
    stage('Checkout') {
        checkout scm
    }

    def props = readProperties file: "${WORKSPACE}/job.properties"

    stage('Fucking sonar') {
        withSonarQubeEnv('SonarQube') {
            sh "sonar-scanner -Dsonar.projectKey=${props.project} -Dsonar.sources=."
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
