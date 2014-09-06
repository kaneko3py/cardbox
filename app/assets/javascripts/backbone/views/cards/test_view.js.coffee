Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.TestQuestionView extends Backbone.View
  template: JST["backbone/templates/cards/test"]

  initialize: ->
    @count = 0

  events:
    "click #test-ok": "new_answer"
    "click #test-next": "save_answer"

  new_answer: ->
    @answer = new Cardbox.Models.Answer()
    @answer.set("answer",$("").text())

    $("#modal-test-question").addClass("hidden")
    $("#modal-test-answer").removeClass("hidden")

  save_answer: ->
    @count++
    if @count >= 5
        $("#test-modal").modal("hide")

    @answer.set("rate",5)
    # @answer.save()

    $("#modal-test-answer").addClass("hidden")
    $("#modal-test-question").html(@render().$el.find("#modal-test-question").html())
    $("#modal-test-answer").html(@render().$el.find("#modal-test-answer").html())
    $("#modal-test-question").removeClass("hidden")

  render: ->
    @$el.html(@template(@options.questions.models[@count].toJSON()))
    return this
