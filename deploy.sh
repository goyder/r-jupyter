#!/usr/bin/env bash
docker-compose down && docker-compose rm -v && docker-compose build && docker-compose up 
