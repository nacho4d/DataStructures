#!/usr/bin/env bash

# Swift Coverage Results Import
# https://docs.sonarqube.org/pages/viewpage.action?pageId=6963001
#
# Original source
# https://github.com/SonarSource/sonar-scanning-examples/blob/master/swift-coverage/swift-coverage-example/xccov-to-sonarqube-generic.sh

set -euo pipefail

function convert_file {
  local xccovarchive_file="$1"
  local file_name="$2"
  local xccov_options="$3"
  echo "  <file path=\"$file_name\">"
  # Ignore errors (2> /dev/null) because sometimes xcode output pollutes input of the next command
  xcrun xccov view $xccov_options --file "$file_name" "$xccovarchive_file" 2> /dev/null | \
    sed -n '
    s/^ *\([0-9][0-9]*\): 0.*$/    <lineToCover lineNumber="\1" covered="false"\/>/p;
    s/^ *\([0-9][0-9]*\): [1-9].*$/    <lineToCover lineNumber="\1" covered="true"\/>/p
    '
  echo '  </file>'
}

function xccov_to_generic {
  echo '<coverage version="1">'
  for xccovarchive_file in "$@"; do
    local xccov_options=""
    if [[ $xccovarchive_file == *".xcresult"* ]]; then
      xccov_options="--archive"
    fi
    # Ignore errors (2> /dev/null) because sometimes xcode output pollutes input of the next command.
    # Filter m files since they are not analized by sonar project yet.
    xcrun xccov view $xccov_options --file-list "$xccovarchive_file" 2> /dev/null  | grep -v '.m$' | while read -r file_name; do
      convert_file "$xccovarchive_file" "$file_name" "$xccov_options"
    done
  done
  echo '</coverage>'
}

xccov_to_generic "$@"