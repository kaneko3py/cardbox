class Cardbox.Models.Tag extends Backbone.Model
  paramRoot: 'tag'

class Cardbox.Collections.TagsCollection extends Backbone.Collection
  model: Cardbox.Models.Tag
  url: '/tags'
