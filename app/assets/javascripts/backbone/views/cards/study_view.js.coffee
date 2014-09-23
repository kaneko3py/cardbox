Cardbox.Views.Cards ||= {}

class Cardbox.Views.Cards.StudyView extends Backbone.View
  template: JST["backbone/templates/cards/study"]

  events:
    "click .search-reliability" : "set_reliability"
    "click #search-btn"         : "search"

  set_reliability: (e) ->
    e.preventDefault()
    e.stopPropagation()

    if $(e.target).hasClass("active")
      $(e.target).removeClass("active")
    else
      $(e.target).addClass("active")

  search: (e) ->
    e.preventDefault()
    e.stopPropagation()

    search_tag = $("#search-card select[name='tag']").val() # リストボックスの値
    except_rel = $(".search-reliability.active").text() # A..Eの押下されたボタン(空白区切り)

    cards = new Cardbox.Collections.CardsCollection()
    if search_tag == "ALL"
      cards.reset @options.cards.where({is_archive: false})
    else
      cards.reset @options.cards.filter( (card)->
          return false unless card.attributes.tag
          card.attributes.tag.indexOf(search_tag) >= 0 &&
          !(except_rel.indexOf(card.attributes.reliability) >=0) &&
          !card.is_archive
      )

    @addAll(cards)

  addAll: (cards) =>
    @$("tbody").empty()
    cards.each( (card)->
      view = new Cardbox.Views.Cards.StudyPartView({card: card})
      @$("tbody").append(view.render().el)
    )

  render: =>
    @$el.html(@template(tags: @options.tags.toJSON() ))
#    @addAll()

    return this