# docker-vsts-powershell
This script enables you use to the docker command line tool during Visual Studio Team Services builds and releases. To add this functionality follow the steps below. Note that to use this script, you'll need to setup your docker host to be accessible via TLS. 

1. Add the powershell script into your repository 
You'll need to add a copy of the powershell script into your repository in order to use it during VSTS builds. 

2. Define the Build Variables 
To use docker commands, you'll need to set up variables for all docker information. This includes the CA, Cert, and Key used for TLS and the DOCKER_HOST and DOCKER_TLS_VERIFY flag. 
![Build Variables](/images/Build-Variables.PNG?raw=true "VSTS Build Variables")

3. Setup Build Task 
Once the script is in the repository and the variables are defined, add a step to the build using the "Powershell" task template. The CA, Cert, and Key values should be passed as arguments to this build step. 

![Build Task](/images/Build-Step.PNG?raw=true "VSTS Build Task")

4. Setup the Cert Path 
In any steps that follow the configured step, the docker.exe tool will now be avaiable. To enable the docker tool to access the certificates created, add the line below to any other tasks. It adds the certificate path information to the current powershell environment. 
```
$env:DOCKER_CERT_PATH = $env:BUILD_SOURCESDIRECTORY
``` 