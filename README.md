
# How to deploy  
Note: assumptions were made on how the app ingests the API_KEY.

# Install Docker 
See, https://docs.docker.com/engine/installation/#supported-platforms
## Clone the build code
```
git clone https://github.com/xyntrix/webapp
```
## Run the docker image build
Replace API_KEY="nnn" with the API key
```
docker build --build-arg API_KEY=`uuidgen` --network host --rm -t webapp:0.1.0 webapp/
```
### Deploy app
```
sudo docker run --network bridge --privileged --name webapp -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 0.0.0.0:80:3000  -d webapp:0.1.0
```
## Access app at http://host
