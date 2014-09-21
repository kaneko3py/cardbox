Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.IndexView extends Backbone.View
  template: JST["backbone/templates/cards/index"]

  initialize: () ->
    @options.active_cards.bind('reset', @addAll)

  addAll: () =>
    @options.active_cards.each(@addOne)

  addOne: (card) =>
    view = new Cardbox.Views.Cards.CardView({model: card})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(cards: @options.active_cards.toJSON() ))
    @addAll()

    return this
