User = require '../lib/models/user'
Team = require '../lib/models/team'

module.exports = (app) ->
  
  app.get "/users/create/:username", (req, res) ->
    { username }  = req.params
    newUser = new User({username: username, name: "cthulhu", isSuper: false})
    newUser.save (err, user) ->
      console.log "saved"
      res.redirect 301, "/users/#{user.username}"

  app.get "/users", (req, res) ->
    User.find {}, (err, users) ->
      console.log users
      res.render "users", {users: users}

  app.get "/users/:username", (req, res) ->
    { username }  = req.params
    User.findOneWithTeams {username: username}, (err, user) ->
      res.render "user", {user: user}

  app.post "/users/:username/createTeam", (req, res) ->
    { username } = req.params
    { name, type} = req.body
    newTeam = new Team({username, name, type})
    newTeam.save (err, team) ->
      res.redirect 301, "/users/"+username
