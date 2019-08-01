# linux_kiosk
A docker with vscode, cpp, vim, etc

This is a docker container which has vscode, cpp, vim, google-chrome, etc, features.  

## Why is this useful?  
1. You can develop all your code in a fully specified environment, which makes it much easier to reproduce and debug

2. Running containers like this within a secure environment with access to data helps us to have an ideal development environment, which ensuring the protected data remains in a secure, single location with no unnecessary duplication.  

## How to use this?  
```
cd linux_kiosk  
docker build -t muh005/linux_kiosk .  
docker run -p 8443:8443 -p 8888:8888 -v $(pwd)/data:/data -v $(pwd)/code:/code --rm -it muh005/linux_kiosk  

```
This will spin up the container -starting up VSCode.
VSCode will be running on:
http://localhost:8843  

Any extensions you install and global configuration you update will persist in the `./data` folder so you don't have to redo it every time you restart the container. By default VSCode will start up with the `./code` folder as the workspace, which you can change by modifying the `docker-entrypoint.sh` file.

