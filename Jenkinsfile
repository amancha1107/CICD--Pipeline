pipeline {
  agent {label 'label11'}
stages {
stage('git-checkout') {
  steps {
git 'https://github.com/vijay2181/CICD-PIPELINE.git'
}
}

  
  stage('PreCheck')
  {
   when { 
     anyOf {
           changeset "samplejar/**"
           changeset "samplewar/**"
     }
   }
   steps {
       script {
          env.BUILDME = "yes" // Set env variable to enable further Build Stages
       }
   }
  }

stage('Build Artifacts')
  {
   when {environment name: 'BUILDME', value: 'yes'}
   steps { 
     echo "helooooooo"
	 }
   }
  }
}

