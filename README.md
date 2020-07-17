SISSO on Docker 

Compiles MPICH from source

-----------------------------------------------------------------------
Docker Desktop for Windows Pro, Enterprise, Educational (WSL2 on OS build 20* or higher is best, WSL1 or Windows containers should also work)
https://docs.docker.com/docker-for-windows/install/

Docker Desktop for Windows Home can be installed:
https://docs.docker.com/docker-for-windows/install-windows-home/

Mac and Linux:
https://docs.docker.com/docker-for-mac/install/
https://docs.docker.com/engine/install/

-----------------------------------------------------------------------
To build:
```
git clone https://github.com/jcklasseter/SISSO_docker/SISSO_docker.git

cd SISSO_docker.git

docker build -t sisso .
```

-----------------------------------------------------------------------
To run, mounting the test data and writing outputs to ./hostData:
`docker run -v $(pwd)/hostData:/root/hostData  -i sisso`

Windows uses different mounting syntax, be in the Users folder:
`docker run -v /run/desktop/mnt/host/c/Users/jckla/SISSO_docker/hostData:/root/hostData -i sometag`

-----------------------------------------------------------------------
Run Notes: Adjust the mpirun # parallel cores in entry.sh low # from laptop
