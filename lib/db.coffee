mongoose = require 'mongoose'

db = mongoose.createConnection('mongodb://localhost/test')

module.exports =
  db:     db

