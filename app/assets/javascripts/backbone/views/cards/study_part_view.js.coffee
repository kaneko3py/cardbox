Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.StudyPartView extends Backbone.View
  template: JST["backbone/templates/cards/study_part"]

  events:
    "click .show-answer" : "showAnswer"
    "click .hide-answer" : "hideAnswer"

  tagName: "tr"

  showAnswer: (e) ->
    e.preventDefault()
    e.stopPropagation()

    tr = $(e.target.parentElement.parentElement)
    tr.find(".answer").removeClass("hidden")
    tr.find(".show-answer").addClass("hidden")
    tr.find(".hide-answer").removeClass("hidden")

  hideAnswer: (e) ->
    e.preventDefault()
    e.stopPropagation()

    tr = $(e.target.parentElement.parentElement)
    tr.find(".answer").addClass("hidden")
    tr.find(".hide-answer").addClass("hidden")
    tr.find(".show-answer").removeClass("hidden")

  render: ->
    @$el.html(@template(@options.card.toJSON()))
    return this
