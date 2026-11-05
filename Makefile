CONTAINER_VERSION:=$(shell awk -F= '/^ARG CONTAINER_VERSION=/{print $$2}' ./Dockerfile)
CONTAINER:=$(shell basename `pwd`)
git:
	git commit -a -m "Update $(CONTAINER) to $(CONTAINER_VERSION)"
	git tag -f -a "v$(CONTAINER_VERSION)" -m "$(CONTAINER_VERSION)"
	git push origin HEAD
	git push origin refs/tags/"v$(CONTAINER_VERSION)" -f
