#! /bin/bash

sonar-scanner \
  -X \
  -Dsonar.projectKey=DataStructuresKey \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=ee4b2751f7ecbf413cd2e67ab8372419fadb2a79