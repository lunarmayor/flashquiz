FlashQuiz.module 'Entities', (Entities, App) ->
  class Entities.CardSetModel extends Backbone.Model
    urlRoot: 'card_sets'
    defaults:
      name: 'Practice Set'
      high_score: 0.0
      cards: new Entities.CardCollection([
        {question: 'IPA stands for:', answer: 'India Pale Ale'},
        {question: 'The liqueur Maraschino is flavoured with which fruit?', answer: 'cherries'},
        {question: 'What is the name of the Japanese wine made from rice?', answer: 'sake'}
      ])

  App.reqres.setHandler 'cardSet', ->
    cardSet = cardSet || new Entities.CardSetModel()
