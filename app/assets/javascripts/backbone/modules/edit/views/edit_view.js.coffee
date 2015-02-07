FlashQuiz.module 'CardSet.Edit', (Edit, App) ->
  class CardView extends Marionette.ItemView
    className: 'card-container'
    template: JST['backbone/modules/edit/templates/card']

  class Edit.View extends Marionette.CompositeView
    template: JST['backbone/modules/edit/templates/card_list']
    childView: CardView
    childViewContainer: 'ul'
