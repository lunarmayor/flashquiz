FlashQuiz.module 'CardSet', (CardSet, App) ->
  class CardSet.Router extends Marionette.AppRouter
    appRoutes:
      '':'edit'
      'play':'show'
  
  API =
    edit: ->
      new CardSet.Edit.Controller()
    show: ->
      new CardSset.Show.Controller()

  App.addInitializer ->
    App.cardSetRouter = new CardSet.Router(controller: API)
