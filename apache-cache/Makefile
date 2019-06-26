DOCKERIMAGE=vognev/apache-cache

.DEFAULT_GOAL := image

image:
	docker build -t $(DOCKERIMAGE) --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} .

start: image
	docker run -it --rm $(DOCKERIMAGE)

deploy: image
	docker run -d --restart=always --name cache -p 8080:8080 $(DOCKERIMAGE)

push: image
	docker push $(DOCKERIMAGE)
