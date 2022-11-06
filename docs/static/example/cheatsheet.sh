#!/bin/bash

rerun 'ruby business.rb'
rerun 'ruby web.rb'

curl -X POST localhost:4567/api/questions --data-raw '{"title": "asdf", "body": "asdf2"}'

curl -X DELETE localhost:4567/api/questions/81837abd-368c-4108-98fb-4bf8163911c1

npx localtunnel -s pojntfx -p 4567
