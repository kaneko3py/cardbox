class Cardbox.Models.Card extends Backbone.Model
  paramRoot: 'card'

  defaults:
    user_id: null
    no: null
    tag: null
    question: null
    answer: null
    comment: null
    good_answers: null
    total_answers: null
    reliability: null
    created_at: null
    updated_at: null
    is_archive: false

class Cardbox.Collections.CardsCollection extends Backbone.Collection
  model: Cardbox.Models.Card
  url: '/cards'
