BUILDSCRIPT=/build/build.sh
DOCKERIMAGE=vognev/debian-stretch

.DEFAULT_GOAL := image

rootfs.tar.gz:
	docker run --privileged -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} \
	-it --rm -v ${PWD}:/build debian:stretch-slim $(BUILDSCRIPT)

image: rootfs.tar.gz
	docker build \
	  --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} \
	  -t $(DOCKERIMAGE) .

push: image
	docker push $(DOCKERIMAGE)

clean:
	sudo rm -rf rootfs rootfs.tar.gz