# ngrok client and server container

## Directories

**Server**

```
/ngrok
|- /bin
   |- ngrokd
|- /certs
   |- device.crt
   |- device.key
```

**Client**

```
/ngrok
|- /bin
   |- ngrok
|- /config
   |- ngrok.yml
```

## Server Deployment

```
make kube_deploy
```

## Client Getting Started

Create ngrok folder

```
mkdir -p ngrok && cd $_
```

Download essential files

```
curl -O -L https://raw.githubusercontent.com/mixslice/docker-ngrok/master/client/docker-compose.yml
curl -O -L https://raw.githubusercontent.com/mixslice/docker-ngrok/master/config/ngrok.yml
```

Then simply run

```
docker-compose up -d
```
