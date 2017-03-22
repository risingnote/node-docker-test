'use strict';

const express = require('express');
const http = require('http')
const https = require('https')
const fs = require('fs')

const config = require('../config/startup.json')

const isHttps = config.https && config.https === true 

const app = express();

app.get('/', function (req, res) {
  res.send('Hello world from node-docker-test\n')
});

if (isHttps) {
  // Note certfile should be concatenation of server certificate and any intermediate certs.
  const httpsOptions = {
    key: fs.readFileSync(config.keyFile),
    cert: fs.readFileSync(config.certFile)
  }
  const httpsServer = https.createServer(httpsOptions, app)
  httpsServer.listen(8443, () => {
    console.log(`Running https on port ${8443}.`)
  })
} else {
  const httpServer = http.createServer(app)

  httpServer.listen(8080, () => {
    console.log(`Running http on port ${8080}.`)
  })
}

