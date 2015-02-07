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
        @activeCard = false
        if @currentCard.get('answer') is @ui.answerBar.val()
          @ui.answerBar.css('color': 'green')
          @stopTime = Date.now()
          @calculateCardScore()
          @checkForGameEnd()
        else
          @addX()
          @ui.answerBar.val('')
          @activeCard = true
          @numberOfTries += 1
          if @numberOfTries > 2
            @checkForGameEnd()
    
    checkForGameEnd: ->
      @activeCard = false
      @clearTries()
      @currentCardNumber += 1
      if @currentCardNumber >= @cards.length
        @endGame()
      else
        @startCountdown()

    clearTries: ->
      @numberOfTries = 0
      @$el.find('.tries').text('')
    
    addX: ->
      @$el.find('.tries').append('x')
    
    calculateCardScore: ->
      tryMultiplier = 1 - .25 * @numberOfTries
      timeElapsed = (@stopTime - @startTime) / 1000
      timeMultiplier = if timeElapsed <= 10
                         1
                       else if timeElapsed <= 20
                         0.9
                       else if timeElapsed <= 30
                         0.8
                       else
                         0.75

       @totalPoints += (100 / @cards.length) * tryMultiplier * timeMultiplier
       @$el.find('.total-points').text(Math.floor(@totalPoints, 2))

    endGame: ->
      if @model.get('high_score') < @totalPoints
        @model.set('high_score', @totalPoints)
      
      attributes = _.extend(@model.attributes, {totalPoints: @totalPoints})
      @ui.gamespace.html(JST['backbone/modules/show/templates/results'](attributes))
