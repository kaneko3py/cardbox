class Cardbox.Routers.CardsRouter extends Backbone.Router
  initialize: (options) ->
    @cards = new Cardbox.Collections.CardsCollection()
    @cards.reset options.cards
    @archived_cards = new Cardbox.Collections.ArchivedCardsCollection()
    @archived_cards.reset options.archived_cards

  routes:
    "index"         : "index"
    "new"           : "newCard"
    "archive"       : "archive"
    "setting"       : "setting"
    "test"          : "test"
    ":id"           : "showCard"
    ":id/edit"      : "editCard"
    ":id/archive"   : "archiveCard"
    ":id/unarchive" : "unarchiveCard"
    ".*"            : "index"

  index: ->
    $("div.navbar ul li").removeClass("active");
    $("div.navbar ul li :eq(0)").addClass("active");  # 0: HOME

    @view = new Cardbox.Views.Cards.IndexView(cards: @cards)
    $("#cards").html(@view.render().el)

  newCard: ->
    @view = new Cardbox.Views.Cards.NewView(collection: @cards)
    $("#cards").html(@view.render().el)

  showCard: (id) ->
    card = @cards.get(id)

    @view = new Cardbox.Views.Cards.ShowView(model: card)
    $("#cards").html(@view.render().el)

  editCard: (id) ->
    card = @cards.get(id)

    @view = new Cardbox.Views.Cards.EditView(model: card)
    $("#cards").html(@view.render().el)

  archiveCard: (id) ->
    card = @cards.get(id)

    card.set('is_archive',true)
    card.save()

    window.location.hash = "index"

  unarchiveCard: (id) ->
    card = @archived_cards.get(id)

    card.set('is_archive',false)
    card.save()

    window.location.hash = "index"

  archive: ->
    $("div.navbar ul li").removeClass("active");
    $("div.navbar ul li :eq(1)").addClass("active");  # 1: ARCHIVE

    @view = new Cardbox.Views.Cards.ArchiveView(archived_cards: @archived_cards)
    $("#cards").html(@view.render().el)

  settings: (id) ->
    $("div.navbar ul li").removeClass("active");
    $("div.navbar ul li :eq(2)").addClass("active");  # 2: LIST

    card = @cards.get(id)
    # ...

  test: () ->
    questions = new Cardbox.Collections.QuestionsCollection()
    questions.fetch().done( ->
        @view = new Cardbox.Views.Cards.TestQuestionView(questions: questions)
        $("#test-modal").html(@view.render().el)
        $("#test-modal").on('hidden.bs.modal', ->
            window.location.hash = "index"
        )
        $("#test-modal").modal({show: true, backdrop: 'strict', keybord: false})
    )




