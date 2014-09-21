Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.InfoView extends Backbone.View
  template: JST["backbone/templates/cards/info"]

  render: ->
    @$el.html(@template(@options.info.toJSON()))
    return this