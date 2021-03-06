define [
  "async"
  "backbone"
  "handlebars"
  "collections/actions"
  "views/action-thumbnail-view"
  "templates"
], (async, Backbone, Handlebars, Actions, ActionThumbnailView) ->

  class ActingView extends Backbone.View

    className: "container"

    template: Handlebars.templates["acting"]

    initialize: ->

      @actions = new Actions
      @actionThumbnailViews = []

      @listenTo @actions, "reset", @_renderActionList
      @actions.fetch
        reset: true

    render: ->
      @$el.html @template()
      @_renderActionList()

    remove: ->
      @_removeActionList()
      super

    _renderActionList: ->
      @_removeActionList()
      $actionList = @$ "#action-list"
      @actions.each (action) ->
        actionThumbnailView = new ActionThumbnailView
          model: action
          className: "col-xs-6 margin-bottom-20"
        $actionList.append actionThumbnailView.$el
        actionThumbnailView.render()
        @actionThumbnailViews.push actionThumbnailView
      , @

    _removeActionList: ->
      while view = @actionThumbnailViews.shift()
        view.remove()
      @$("#action-list").empty()