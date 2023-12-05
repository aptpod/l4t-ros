ROS_DISTRO?=foxy
BASE_IMAGE_NAME?=l4t-ros
RELEASE?=r32.7

REGISTRY=reg.aptpod.io
REGISTRY_PATH=intdash-robotics/l4t-ros
BASE_IMAGE=$(REGISTRY)/$(REGISTRY_PATH)/$(BASE_IMAGE_NAME)

all: login image

login:
	docker login $(REGISTRY)

image: login
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-ros-core-$(RELEASE) -f ros-core/Dockerfile ros-core
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-ros-base-$(RELEASE) -f ros-base/Dockerfile ros-base
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-desktop-$(RELEASE) -f desktop/Dockerfile desktop

push: login
	docker push $(BASE_IMAGE):$(ROS_DISTRO)-ros-core-$(RELEASE)
	docker push $(BASE_IMAGE):$(ROS_DISTRO)-ros-base-$(RELEASE)
	docker push $(BASE_IMAGE):$(ROS_DISTRO)-desktop-$(RELEASE)
