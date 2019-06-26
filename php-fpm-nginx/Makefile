DOCKERIMAGE=vognev/php-fpm-nginx:7.0

.DEFAULT_GOAL := image

image:
	docker build -t $(DOCKERIMAGE) .

push: image
	docker push $(DOCKERIMAGE)