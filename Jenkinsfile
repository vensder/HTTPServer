
properties([buildDiscarder(logRotator(
	artifactDaysToKeepStr: '10',
    artifactNumToKeepStr: '10',
    daysToKeepStr: '10',
    numToKeepStr: '10')),
    pipelineTriggers([])
])

node('Build-Server'){

    def workspace = pwd()
    def service_name = "http-server"

    stage("Cleanup workspace"){
        sh("sudo chown -R `id -u` ${workspace}")
        deleteDir()
    }

    stage("Checkout") {
        checkout scm
    }

    stage("Build jar file"){
    	sh("""
    		docker run --rm --name ${service_name}-${env.BRANCH_NAME} \
    			-v ${workspace}:/tmp \
    			-w /tmp \
    			openjdk:8-jdk-slim javac -version && \
    			echo ${env.BUILD_TAG}

			docker run --rm --name ${service_name}-\"${env.BRANCH_NAME}\" \
    			-v \"${workspace}\":/tmp \
    			-w /tmp \
    			openjdk:8-jdk-slim javac -d classes/ source/HTTPServer.java && \
			cd classes/ && \
			jar cvfm HTTPServer.jar manifest.txt *.class
    	""")
    }

    def docker_stop_rm = """
	    docker stop ${service_name} || true
	    docker rm   ${service_name} || true
    """

    def build_script = """
    		docker build -t ${service_name} .
    		${docker_stop_rm}
    		docker run -d --name ${service_name} -p 8000:8000 http-server
    		sleep 10
    		curl http://localhost:8000/java
    		${docker_stop_rm}
    	"""

    stage("Build and test docker image"){
    	sh("${build_script}")
    }
}
