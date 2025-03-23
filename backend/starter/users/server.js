const http = require("http");
const express = require('express')
const expressApp = express()
const port = 3000
const userRoutes = require('./src/users/routes')

expressApp.use(express.json());
expressApp.use(express.urlencoded({extended: true}))
expressApp.use(userRoutes)
expressApp.get('/', (req, res) => {
  res.send('Hello World!')
})

const server = http.createServer(expressApp)

server.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})