
properties([buildDiscarder(logRotator(
	artifactDaysToKeepStr: '10',
    artifactNumToKeepStr: '10',
    daysToKeepStr: '10',
    numToKeepStr: '10')),
    pipelineTriggers([])
])

node('Build-Server') {

    def workspace = pwd()

    stage("Cleanup workspace") {
        sh("sudo chown -R `id -u` ${workspace}")
        deleteDir()
    }

    stage("Checkout") {
        checkout scm
    }
}

