#!/bin/bash

set -e

source "$HOME/.rvm/scripts/rvm"
( cd '%%install.path%%'; RAILS_ENV=production bundle exec tasks_scheduler "$@" )
