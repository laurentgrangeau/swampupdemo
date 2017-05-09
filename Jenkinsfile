node('master') {
    stage('Checkout') {
        checkout scm
    }

    def props = readProperties('job.properties')

    stage('Tests') {
        sh 'echo "very good yes yes a+"'
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