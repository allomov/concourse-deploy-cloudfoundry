#!/bin/bash -e

curl -SsL -u "$CONCOURSE_USER:$CONCOURSE_PASS" "$CONCOURSE_URL/api/v1/cli?arch=amd64&platform=linux" > fly
chmod +x fly

./fly login -t here -c "$CONCOURSE_URL" -u "$CONCOURSE_USER" -p "$CONCOURSE_PASS"
./fly login -t here get-pipeline -p $BUILD_PIPELINE_NAME > $BUILD_PIPELINE_NAME.yml
./fly login -t here set-pipeline -p $BUILD_PIPELINE_NAME -c $BUILD_PIPELINE_NAME.yml \
  -v elastic_runtime_version=$(<product_version) \
  -v stemcell_version=$(<stemcell_version)

#eof