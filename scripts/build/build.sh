#!/bin/sh

# Copyright 2016 The Kubernetes Authors.
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

set -o errexit
set -o nounset
set -o pipefail

if [ -z "${OS:-}" ]; then
    echo "OS must be set"
    exit 1
fi
if [ -z "${ARCH:-}" ]; then
    echo "ARCH must be set"
    exit 1
fi
if [ -z "${VERSION:-}" ]; then
    echo "VERSION must be set"
    exit 1
fi

BUILD="${VERSION}-${OS}-${ARCH}"

SRC=install-cni.sh
DST=${GOPATH}/bin/netd-init

rm -rf "${DST}"
mkdir -p "$(dirname "${DST}")"
sed -e "s/__BUILD__/${BUILD}/; w${DST}" -n "${SRC}"
chmod a+x "${DST}"
