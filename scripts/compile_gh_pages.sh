#!/bin/bash

git checkout gh-pages
bundle exec ./scripts/swagger_to_json.rb
git add swagger.json
git commit -m "Update swagger.json"
git push
