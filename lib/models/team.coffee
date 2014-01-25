mongoose  = require 'mongoose'
{db}      = require '../db'

TeamSchema = mongoose.Schema
  username:     { type: String, index: true }
  name:         { type: String }
  type:         { type: String }
  league:       { type: Number }

Team = db.model("Team", TeamSchema)
module.exports = Team
