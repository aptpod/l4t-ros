ROS_DISTRO?=melodic
BASE_IMAGE_NAME?=l4t-ros
RELEASE?=r32.7

BASE_IMAGE=$(BASE_IMAGE_NAME)

all: image

image:
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-ros-core-$(RELEASE) -f ros-core/Dockerfile ros-core
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-ros-base-$(RELEASE) -f ros-base/Dockerfile ros-base
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-robot-$(RELEASE) -f robot/Dockerfile robot
	docker build -t $(BASE_IMAGE):$(ROS_DISTRO)-desktop-$(RELEASE) -f desktop/Dockerfile desktop
