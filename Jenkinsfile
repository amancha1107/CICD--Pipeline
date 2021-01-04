pipeline {
  agent {label 'label11'}

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
    script { 
	    /* Define the Artifactory Server details */
        def server = Artifactory.server 'jfrog'                       //Artifactory.server is a fuction got by installing artifactory plugin
        def uploadSpec = """{
            "files": [{
                "pattern": "samplewar/target/samplewar.war",                                  
                "target": "demoCICD"                                                        
            }]
        }"""                                                                                                //demoCICD is the repository name in jfrog
        
        /* Upload the war to  Artifactory repo */
        server.upload(uploadSpec)
    }
   }
  }



}
}
