node('master') {
    stage('Checkout') {
        checkout scm
    }

    stage('Tests') {
        withEnv(["PATH+PYTHON=${WORKSPACE/python/bin}"]) {
            sh 'pip install tox'
            sh 'tox'
        }
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
