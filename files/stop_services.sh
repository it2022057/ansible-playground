#!/bin/bash

sudo systemctl stop mailhog.service || true

sudo systemctl stop minio.service || true

sudo systemctl stop mariadb.service || true

sudo systemctl stop spring.service || true  

sudo systemctl stop nginx.service || true
