pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Verify Environment') {
            steps {
                sh '''
                python3 --version
                robot --version
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh '''
                rm -rf results
                mkdir -p results
                robot -d results tests/
                '''
            }
        }
    }

    post {
        always {
            step([
                $class: 'RobotPublisher',
                outputPath: 'results',
                outputFileName: 'output.xml',
                reportFileName: 'report.html',
                logFileName: 'log.html'
            ])

            archiveArtifacts artifacts: 'results/*', allowEmptyArchive: true
        }
    }
}

