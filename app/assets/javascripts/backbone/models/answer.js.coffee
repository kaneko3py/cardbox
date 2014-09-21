class Cardbox.Models.Answer extends Backbone.Model
  paramRoot: 'answer'
  urlRoot: 'answers'

  defaults:
    user_id: null
    answer: null
    rate: 0

