Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.TestQuestionView extends Backbone.View
  template: JST["backbone/templates/cards/test"]

  initialize: ->
    @count = 0

  events:
    "click #test-ok": "new_answer"
    "click #test-next": "save_answer"
    "click #test-clone.btn": "clone_card"

  new_answer: ->
    @answer = new Cardbox.Models.Answer()
    @answer.set("answer",$("#answer").val())

    # best answers
    $(".raty").raty({readOnly: true, score: ->
       @getAttribute('data-score');
    })

    # your answer
    your_answer = $("#answer").val()
    ans_def_score = 0;
    @question.get("answers").forEach( (ans) ->
        if ans.answer == your_answer
            ans_def_score = ans.rate
    )
    $("#your-answer .answer-insert").text(your_answer)
    $(".raty-answer").raty({readOnly: true, score: ans_def_score})
    $(".raty-answer-big").raty(starOff: 'big-star-off.png', starOn: 'big-star-on.png', score: ans_def_score, click: (score,evt)->
       $(".raty-answer").raty({readOnly:true, score: score})
    )

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

  clone_card: ->
    @card = new Cardbox.Models.Card()
    @card.set("question", @question.attributes.question)
    @card.set("answer"  , @question.attributes.answer)
    @card.set("is_link" , true)
    @card.set("original", @question.attributes.id)
    @card.save()

    $("#test-clone").text("cloned.")
    $("#test-clone").prop("disabled", true);

  render: ->
    @question = @options.questions.models[@count]
    @$el.html(@template({question: @question.toJSON()}))
    return this
