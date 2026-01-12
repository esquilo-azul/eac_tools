#!/bin/bash

set -e

source "/etc/profile"
( cd '%%install.path%%'; RAILS_ENV=production bundle exec tasks_scheduler "$@" )
