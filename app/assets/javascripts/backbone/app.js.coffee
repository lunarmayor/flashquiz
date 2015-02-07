@FlashQuiz = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    mainRegion: 'main'

  App.on 'start', (options) ->
    if Backbone.history
      Backbone.history.start(pushState: true)

  App
