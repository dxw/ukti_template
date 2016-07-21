#! /bin/bash
set -e

rm -rf vendor/mustache_ukti_template/*

# TODO: Pick the latest, not every matching tgz file!
tar -zxvf ../../../pkg/mustache_ukti_template-*.tgz -C vendor/

bundle install --path vendor/bundle

bundle exec ruby test_render.rb
