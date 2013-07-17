#!/bin/bash
NODE_DEBUG=--debug \
ROOT_URL=http://42do.ru/ \
PORT=60080 \
MONGO_URL=mongodb://localhost/dev_contact \
MAIL_URL=smtp://localhost:25 \
node bundle/main.js
