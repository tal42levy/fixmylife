mongoose  = require 'mongoose'
Team      = require './team'
{db}      = require '../db'

UserSchema = mongoose.Schema
  username:         { type: String, index: { unique: true } }
  name:             { type: String }
  isSuper:          { type: Boolean }

UserSchema.statics =
  findWithTeams: (params, cb) ->
    this.find params, (err, users) ->
      cb(err) if err
      mergeWithTeams = (user) ->
        Team.find {username: user.username }, (err, teams) ->
          cb(err) if err
          user.teams = teams
          cb(err, user)
      async.map users, mergeWithTeams, cb

  findOneWithTeams: (params, cb) ->
    this.findOne params, (err, user) ->
      cb(err) if err
      Team.find {username: user.username }, (err, teams) ->
        cb(err) if err
        user.teams = teams
        cb(err, user)

User = db.model("User", UserSchema)

module.exports = User
