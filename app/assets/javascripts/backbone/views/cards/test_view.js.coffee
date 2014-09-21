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
    @answer.set("answer",$("#answer").val())

    $("#your-answer .answer-insert").text($("#answer").val())
    $(".raty-answer").raty({readOnly: true})
    $(".raty-answer-big").raty(starOff: 'big-star-off.png', starOn: 'big-star-on.png', click: (score,evt)->
       $(".raty-answer").raty({readOnly:true, score: score})
    )
    $(".raty").raty({readOnly: true, score: ->
       @getAttribute('data-score');
    })

    $("#modal-test-question").addClass("hidden")
    $("#modal-test-answer").removeClass("hidden")

  save_answer: ->
    @count++
    if @count >= @options.questions.models.length
        $("#test-modal").modal("hide")
        return

    @answer.set("card_id",@question.id)
    _rate = $('.raty-answer-big input[type="hidden"]').val() || 0
    @answer.set("rate",_rate)
    @answer.save()

    $("#modal-test-answer").addClass("hidden")
    $("#modal-test-question").html(@render().$el.find("#modal-test-question").html())
    $("#modal-test-answer").html(@render().$el.find("#modal-test-answer").html())
    $("#modal-test-question").removeClass("hidden")

  render: ->
    @question = @options.questions.models[@count]
    @$el.html(@template({question: @question.toJSON()}))
    return this
