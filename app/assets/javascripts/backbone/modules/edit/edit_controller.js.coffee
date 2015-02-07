FlashQuiz.module 'CardSet.Edit', (Edit, App) ->
  class Edit.Controller extends Marionette.Controller
    initialize: ->
      cardSet = App.request('cardSet')
      cards = cardSet.get('cards')

      editView = new Edit.View(model: cardSet, collection: cards)
      App.mainRegion.show(editView)
