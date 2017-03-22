'use strict';

const express = require('express');
const http = require('http')
const https = require('https')
const fs = require('fs')

const certs = require('../certs/config.json')

const isHttps = certs.https && certs.https === true 

const app = express();

app.get('/', function (req, res) {
  res.send('Hello world from node-docker-test\n')
});

if (isHttps) {
  // Note certfile should be concatenation of server certificate and any intermediate certs.
  const httpsOptions = {
    key: fs.readFileSync(certs.keyFile),
    cert: fs.readFileSync(certs.certFile)
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

