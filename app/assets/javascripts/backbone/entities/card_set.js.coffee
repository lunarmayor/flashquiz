FlashQuiz.module 'Entities', (Entities, App) ->
  class Entities.CardSetModel extends Backbone.Model
    urlRoot: 'card_sets'
    defaults:
      name: 'Practice Set'
      high_score: 0.0
      cards: new Entities.CardCollection([])

  App.reqres.setHandler 'cardSet', ->
    cardSet = cardSet || new Entities.CardSetModel()
