Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.EditView extends Backbone.View
  template: JST["backbone/templates/cards/edit"]

  events:
    "submit #edit-card": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (card) =>
        @model = card
        # window.location.hash = "/#{@model.id}"
        window.location.hash = "#index"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
