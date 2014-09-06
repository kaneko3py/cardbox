Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.ArchiveView extends Backbone.View
  template: JST["backbone/templates/cards/archive"]

  initialize: () ->
    @options.archived_cards.bind('reset', @addAll)

  addAll: () =>
    @options.archived_cards.each(@addOne)

  addOne: (card) =>
    view = new Cardbox.Views.Cards.CardView({model : card})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(cards: @options.archived_cards.toJSON() ))
    @addAll()

    return this
