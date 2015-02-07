FlashQuiz.module 'CardSet.Show', (Show, App) ->
  class Show.Controller extends Marionette.Controller
    initialize: ->
      cardSet = App.request('cardSet')
      gameView = new Show.View(model: cardSet)
      App.mainRegion.show(gameView)

 
