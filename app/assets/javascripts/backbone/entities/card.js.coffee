FlashQuiz.module 'Entities', (Entities, App) ->
  class Entities.CardModel extends Backbone.Model
    urlRoot: 'cards'
    defaults: 
      question: ''
      answer: ''
  
  class Entities.CardCollection extends Backbone.Collection
    url: 'cards'
    model: Entities.CardModel
