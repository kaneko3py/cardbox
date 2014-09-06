class Cardbox.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    name: null
    password: null
    lock: null

class Cardbox.Collections.UsersCollection extends Backbone.Collection
  model: Cardbox.Models.User
  url: '/users'
