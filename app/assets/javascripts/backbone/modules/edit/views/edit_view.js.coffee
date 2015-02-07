FlashQuiz.module 'CardSet.Edit', (Edit, App) ->
  class CardView extends Marionette.ItemView
    className: 'card-container'
    template: JST['backbone/modules/edit/templates/card']
    
    events:
      'click .destroy': -> @model.destroy()

  class Edit.View extends Marionette.CompositeView
    template: JST['backbone/modules/edit/templates/card_list']
    childView: CardView
    childViewContainer: 'ul'

    events:
      'click .new': 'toggleForm'
      'click .create': 'createCard'
      'click .play': 'startGame'

    startGame: ->
      App.cardSetRouter.navigate('play', trigger: true)

    toggleForm: ->
      @$el.find('form').toggle()
      @$el.find('.new').toggle()
      @$el.find('.question').focus() if @$el.find('form').is(':visible')

    createCard: ->
      question = @$el.find('.question').val()
      answer = @$el.find('.answer').val()
      
      unless(answer is  '' or  question is '')
        @collection.add(question: question, answer: answer)
        @toggleForm()
        @$el.find('textarea').val('')

