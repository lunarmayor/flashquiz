FlashQuiz.module 'CardSet.Show', (Show, App) ->
  class Show.View extends Marionette.ItemView
   template: JST['backbone/modules/show/templates/game_space'] 
   events:
     'click .start': 'startGame'
     'keyup input': 'submit'

   ui:
     gamespace: '.card.large'
     answerBar: '.answer-bar input'

   startGame: ->
     @activeCard = false
     @currentCardNumber = 0
     @numberOfTries = 0
     @totalPoints = 0
     @cards = @model.get('cards').shuffle()
     @startCountdown()

   startCountdown: ->
     @ui.gamespace.text(3)
     count = 2
     countdown = setInterval( =>
       @ui.gamespace.text(count)
       
       if count is 0
         clearInterval(countdown)
         @playCard()
       else
         @ui.gamespace.text(count)
         count = count - 1
     , 1000)
    
    playCard: ->
      @activeCard = true
      @currentCard = @cards[@currentCardNumber]
      @$el.find('.card').text(@currentCard.get('question'))
      @startTime = Date.now()
      @ui.answerBar.css(color: 'black').val('')
      @ui.answerBar.focus()

    submit: (e) =>
      if e.which is 13 and @activeCard
        if @currentCard.get('answer') is @ui.answerBar.val()
          @ui.answerBar.css('color': 'green')
          @stopTime = Date.now()
          #@calculateCardScore()
          @checkForGameEnd()
        else
          @addX()
          @ui.answerBar.val('')
          @numberOfTries += 1
          if @numberOfTries > 2
            @checkForGameEnd()
    
    checkForGameEnd: ->
      @clearTries()
      @currentCardNumber += 1
      if @currentCardNumber >= @cards.length
        @endGame()
      else
        @startCountdown()
      
    clearTries: ->
      @$el.find('.tries').text('')
    
    addX: ->
      @$el.find('.tries').append('x')
