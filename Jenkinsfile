
properties([buildDiscarder(logRotator(
	artifactDaysToKeepStr: '10',
    artifactNumToKeepStr: '10',
    daysToKeepStr: '10',
    numToKeepStr: '10')),
    pipelineTriggers([])
])

def service_name = "http-server"

def docker_run_task(serviceName, taskParams) {
    sh("""docker run --rm --name ${serviceName}-${env.BRANCH_NAME} \
    			-v ${workspace}:/tmp \
    			-w /tmp \
    			openjdk:8-jdk-slim ${taskParams}""")
}

node('Build-Server'){

    def workspace = pwd()

    stage("Cleanup workspace"){
        sh("sudo chown -R `id -u` ${workspace}")
        deleteDir()
    }

    stage("Checkout") {
        checkout scm
    }

    stage("Test javac version"){
    	docker_run_task("$service_name","javac -version && echo ${env.BRANCH_NAME}")
    }
    
    def build_jar = """javac -d classes/ source/HTTPServer.java && \
						cd classes/ && \
						jar cvfm HTTPServer.jar manifest.txt *.class"""
    
    stage("Build jar file"){
    	docker_run_task("$service_name", "$build_jar")
    }

    def docker_stop_rm = """
	    docker stop ${service_name} || true
	    docker rm   ${service_name} || true
    """

    def build_script = """
    		docker build -t ${service_name} .
    		${docker_stop_rm}
    		docker run -d --name ${service_name} -p 8000:8000 http-server
    		sleep 5
    		curl http://localhost:8000/java
    		${docker_stop_rm}
    	"""

    stage("Build and test docker image"){
    	sh("${build_script}")
    }
}
