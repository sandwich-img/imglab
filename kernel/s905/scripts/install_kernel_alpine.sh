#!/bin/sh

set -e

kernel_flavors="linux-amlogic@testing"

apk --update --no-cache add $kernel_flavors
