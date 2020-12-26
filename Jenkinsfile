 pipeline {
  agent {label 'label11'}

parameters {
    booleanParam(name: 'UNITTEST', defaultValue: true, description: 'Enable UnitTests ?')
                    }

stages {


stage('git-checkout') {
  steps {
git 'https://github.com/vijay2181/CICD-PIPELINE.git'
}
}

  
  stage('PreCheck') {
   
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
      script {
	    if (params.UNITTEST) {
		  unitstr = ""
		} else {
		  unitstr = "-Dmaven.test.skip=true"
		}
	
		echo "Building Jar Component ..."
		dir ("./samplejar") {
		   sh "mvn clean package ${unitstr}"
		}

		echo "Building War Component ..."
		dir ("./samplewar") {
           sh "mvn clean package "
		}
	 }
            }
     }


}
}
