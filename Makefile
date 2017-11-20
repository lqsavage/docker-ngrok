CLIENT_IMAGE=493490470276.dkr.ecr.cn-north-1.amazonaws.com.cn/ngrok
SERVER_IMAGE=493490470276.dkr.ecr.cn-north-1.amazonaws.com.cn/ngrokd

.PHONY: all build_server build_client

all: server_all client_all

server_all: build_server sync_server_to_ecr

client_all: build_client sync_client_to_ecr

build_server:
	docker build -f server/Dockerfile -t ngrokd .

build_client:
	docker build -f client/Dockerfile -t ngrok .

sync_server_to_ecr:
	docker tag ngrokd $(SERVER_IMAGE)
	eval $$(aws ecr get-login --no-include-email --region cn-north-1)
	docker push $(SERVER_IMAGE)

sync_client_to_ecr:
	docker tag ngrok $(CLIENT_IMAGE)
	eval $$(aws ecr get-login --no-include-email --region cn-north-1)
	docker push $(CLIENT_IMAGE)

kube_deploy:
	kubectl create -f kubernetes

kube_remove:
	kubectl delete -f kubernetes
