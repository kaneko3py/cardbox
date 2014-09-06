class Cardbox.Models.Card extends Backbone.Model
  paramRoot: 'card'

  defaults:
    user_id: null
    no: null
    question: null
    answer: null
    comment: null
    is_archive: "false"

class Cardbox.Collections.CardsCollection extends Backbone.Collection
  model: Cardbox.Models.Card
  url: '/cards'

class Cardbox.Models.ArchivedCard extends Backbone.Model
  paramRoot: 'card'
  defaults: {}

class Cardbox.Collections.ArchivedCardsCollection extends Backbone.Collection
  model: Cardbox.Models.ArchivedCard
  url: '/archived/cards'
