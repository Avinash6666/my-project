node{
    
    stage('Clone repo'){
        git credentialsId: 'GIT-Credentials', url: 'https://https://github.com/Avinash6666/my-java-web-app.git'
    }
    
    stage('Maven Build'){
        def mavenHome = tool name: "Maven-3.8.6", type: "maven"
        def mavenCMD = "${mavenHome}/bin/mvn"
        sh "${mavenCMD} clean package"
    }
    
    stage('SonarQube analysis') {       
        withSonarQubeEnv('Sonar-Server-7.8') {
       	sh "mvn sonar:sonar"    	
    }
        
    stage('upload war to nexus'){
	steps{
		nexusArtifactUploader artifacts: [	
			[
				artifactId: 'my-web-app',
				classifier: '',
				file: 'target/my-web-app.war',
				type: war		
			]	
		],
		credentialsId: 'nexus3',
		groupId: 'in.avinash',
		nexusUrl: '',
		protocol: 'http',
		repository: 'avinash-release'
		version: '1.0.0'
	}
}
    
    stage('Build Image'){
        sh 'docker build -t avinash/myjavawebapp .'
    }
    
    stage('Push Image'){
        withCredentials([string(credentialsId: 'DOCKER-CREDENTIALS', variable: 'DOCKER_CREDENTIALS')]) {
            sh 'docker login -u avinash666 -p ${DOCKER_CREDENTIALS}'
        }
        sh 'docker push avinash666/myjavawebapp'
    }
    
    stage('Deploy App'){
        kubernetesDeploy(
            configs: 'my-web-app-deploy.yml',
            kubeconfigId: 'Kube-Config'
        )
    }    
}
