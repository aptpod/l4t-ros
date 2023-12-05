# Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
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

PLATFORM ?= $(shell uname -m)
ifeq ($(PLATFORM),x86_64)
	DOCKER_BINFMT_MISC = $(shell echo "-v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static")
else ifeq ($(PLATFORM),aarch64)
	DOCKER_BINFMT_MISC = $(shell echo "")
else
	$(error Unsupported architecture)
endif
