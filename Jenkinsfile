
properties([buildDiscarder(logRotator(
	artifactDaysToKeepStr: '10',
    artifactNumToKeepStr: '10',
    daysToKeepStr: '10',
    numToKeepStr: '10')),
    pipelineTriggers([])
])

node('Build-Server'){

    def workspace = pwd()

    stage("Cleanup workspace"){
        sh("sudo chown -R `id -u` ${workspace}")
        deleteDir()
    }

    stage("Checkout") {
        checkout scm
    }

    stage("Build jar file"){
    	sh("""
    		docker run --rm --name http-server-\"${env.BRANCH_NAME}\" \
    			-v \"${workspace}\":/tmp \
    			-w /tmp \
    			openjdk:8-jdk-slim javac -version && \
    			echo \"${env.BUILD_TAG}\"

			docker run --rm --name http-server-\"${env.BRANCH_NAME}\" \
    			-v \"${workspace}\":/tmp \
    			-w /tmp \
    			openjdk:8-jdk-slim javac -d classes/ source/HTTPServer.java && \
			cd classes/ && \
			jar cvfm HTTPServer.jar manifest.txt *.class
    	""")
    }

    stage("Build docker image"){
    	sh("""
    		docker build -t http-server .
    	""")
    }
}