Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.IndexView extends Backbone.View
  template: JST["backbone/templates/cards/index"]

  initialize: () ->
    @options.cards.bind('reset', @addAll)

  addAll: () =>
    @options.cards.each(@addOne)

  addOne: (card) =>
    view = new Cardbox.Views.Cards.CardView({model : card})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(cards: @options.cards.toJSON() ))
    @addAll()

    return this
