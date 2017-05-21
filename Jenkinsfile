node('master') {
    stage('Checkout') {
        checkout scm
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
