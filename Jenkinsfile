pipeline {
  agent {label 'label12'}

parameters {
    booleanParam(name: 'UNITTEST', defaultValue: true, description: 'Enable UnitTests ?')
    booleanParam(name: 'CODEANALYSIS', defaultValue: true, description: 'Enable CODE-ANALYSIS ?')
                    }

stages {


stage('git-checkout') {
  steps {
git 'https://github.com/vijay2181/CICD-PIPELINE.git'
}
}

  
  stage('PreCheck') {
   
   steps {                                   //precheck means validation
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


stage('Code Coverage')
  {
   when {
     allOf {
         expression { return params.CODEANALYSIS }
         environment name: 'BUILDME', value: 'yes'
     }
   }
   steps {
     echo "Running Code Coverage ..."  
	
   }
  }


stage('SonarQube Analysis')                     
  {
    when {environment name: 'BUILDME', value: 'yes'}
    steps{
    echo "running sonarqube analysis"
    }
  }


stage("Quality Gate"){ 
    when {environment name: 'BUILDME', value: 'yes'}
    steps{
	 echo "running quality gate"
               }
               }


stage('Stage Artifacts') 
  {          
  
   when {environment name: 'BUILDME', value: 'yes'}
   steps {          
    echo "stage JFROG Artifacts"
   }
  }


stage('Build Image') 
  {
    when {environment name: 'BUILDME', value: 'yes'}
    steps{
      script {
          docker.withRegistry( 'https://registry.hub.docker.com', 'dockerhub' ) {
             /* Build Docker Image locally */
             myImage = docker.build("vijay2181/productimage:01") 

               //'dockerhub' is the credential ID............. docker.withRegistry is a function.
               //docker.build is default function which creates image from dockerfile which should be available from same folder your workspace

             /* Push the container to the Registry */
             myImage.push()                               //it wiil try to create an image with samge tag and push to our registry 
                                                                     //so we need to write dockerfile for this
          }
      }
    }
  }


stage ('Deploy'){
    when {environment name: 'BUILDME', value: 'yes'}
    steps {
        git branch: 'master', url: 'https://github.com/vijay2181/CICD-PIPELINE.git'
        step([$class: 'DockerComposeBuilder', dockerComposeFile: 'docker-compose.yml', option: [$class: 'StartAllServices'], useCustomDockerComposeFile: false])

}
}




 } //End of Stages
}
