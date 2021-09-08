pipeline {
    agent any
    tools { // <1>
        maven 'Maven 3.3.9'// <2>
        jdk 'jdk8'// <3>
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"'''// <4>
            }
        }

        stage ('Build') {
            steps {
                echo 'This is a minimal pipeline.'
            }
        }
    }
}