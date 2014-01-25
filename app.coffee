fs          = require 'fs'
express     = require 'express'
http        = require 'http'
jade        = require 'jade'
mongoose    = require 'mongoose'

port    = 3000
app     = express()

app.set('views', "./views")
app.set("view engine", "jade")
app.use("/common", express.static(__dirname + '/common'))
app.use(express.bodyParser())

require('./routes/user')(app)

app.get '/', (req, res) ->
  res.render "index"

app.listen port, ->
  console.log "listening to #{port}"
