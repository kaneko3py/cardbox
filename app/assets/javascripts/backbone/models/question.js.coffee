class Cardbox.Models.Question extends Backbone.Model
  paramRoot: 'question'

class Cardbox.Collections.QuestionsCollection extends Backbone.Collection
  model: Cardbox.Models.Question
  url: '/questions'
