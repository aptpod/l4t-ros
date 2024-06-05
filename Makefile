# Copyright (c) 2020-2022, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DOC     = /usr/share/doc/cuda
VAR     = /var/cuda

UBUNTU_DISTRIB ?= jammy
RELEASE ?= r32.7
TAG     = $(UBUNTU_DISTRIB)-$(RELEASE)
CUDA    ?= 10.2
L4T_CUDA_REGISTRY   ?= "reg.aptpod.io/intdash-robotics/l4t-ros/l4t-cuda"
L4T_BASE_REGISTRY   ?= "reg.aptpod.io/intdash-robotics/l4t-ros/l4t-base"

include $(CURDIR)/common.mk

image:
	mkdir -p ${CURDIR}/dst
	podman build $(DOCKER_BINFMT_MISC) -t $(L4T_CUDA_REGISTRY):$(TAG) \
		--build-arg "RELEASE=$(RELEASE)" --build-arg "CUDA=$(CUDA)" \
		--build-arg "UBUNTU_DISTRIB=$(UBUNTU_DISTRIB)" \
		-f ./Dockerfile.cuda ./
	podman run -t $(DOCKER_BINFMT_MISC) -v $(CURDIR)/dst:/dst $(L4T_CUDA_REGISTRY):$(TAG) sh -c 'cp -r /usr/local/cuda/* /dst'
	podman build $(DOCKER_BINFMT_MISC) -t $(L4T_BASE_REGISTRY):$(TAG) \
		--build-arg "RELEASE=$(RELEASE)" --build-arg "CUDA=$(CUDA)" \
		--build-arg "UBUNTU_DISTRIB=$(UBUNTU_DISTRIB)" \
		-v $(CURDIR)/dst:/dst -f ./Dockerfile.$(UBUNTU_DISTRIB) ./
	podman rm `podman ps -a | grep $(L4T_CUDA_REGISTRY):$(TAG) | head -n1 | awk '{print $$1;}'`
	podman rmi  `podman images | grep $(L4T_CUDA_REGISTRY)  | head -n1 | awk '{print $$3;}'`

push:
	sudo podman save $(L4T_BASE_REGISTRY):$(TAG) | docker load
	docker tag localhost/$(L4T_BASE_REGISTRY):$(TAG) $(L4T_BASE_REGISTRY):$(TAG)
