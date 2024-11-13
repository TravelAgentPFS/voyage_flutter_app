pipeline {
    agent any

    environment {
        // Path to the Flutter installation on your Docker container
        FLUTTER_HOME = '/opt/flutter'
        PATH = "$FLUTTER_HOME/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository code
                git 'https://github.com/TravelAgentPFS/voyage_flutter_app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install Flutter dependencies (this will fetch packages)
                sh 'flutter pub get'
            }
        }

        stage('Run Tests') {
            steps {
                // Run Flutter tests
                sh 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                // Build the APK
                sh 'flutter build apk --release'
            }
        }

        stage('Upload to GitHub Releases') {
            steps {
                // Assuming you have setup GitHub token via Jenkins credentials
                withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                        # Create a new GitHub release
                        git tag -a v${BUILD_NUMBER} -m "Release v${BUILD_NUMBER}"
                        git push origin v${BUILD_NUMBER}

                        # Upload the APK to GitHub releases using the GitHub API
                        curl -H "Authorization: token ${GITHUB_TOKEN}" \
                            -H "Content-Type: application/octet-stream" \
                            --data-binary @build/app/outputs/flutter-apk/app-release.apk \
                            "https://uploads.github.com/repos/TravelAgentPFS/voyage_flutter_app/releases/${BUILD_NUMBER}/assets?name=app-release.apk"
                    '''
                }
            }
        }
    }
    post {
        always {
            // Clean up the workspace after the pipeline is done
            cleanWs()
        }
    }
}
