$ ->
  class SlideState extends Backbone.Model
    defaults:
      slideNumber: 1
      isArrowLeft: false
      isArrowRight: true
    increase: (key, val)->
      @set(key, @get(key) + val)
    decrease: (key, val)->
      @set(key, @get(key) - val)

  class SliderData extends Backbone.Model
    defaulats:
      url: ''
      title: ''
      description: ''

  class SlideDataList extends Backbone.Collection
    url: ''
    initialize: ->
      resList = demoData
      for res in resList
        sliderData = new SliderData
          url: res.url
          title: res.title
          description: res.description
        @add(sliderData)

  class Slider extends Backbone.View
    el: '#wrapper'
    model:
      state: {}
    collection:
      slideDataList: {}
    initialize: ->
      self = @
      @render()

      @model.state.bind 'change', ->
        self.renderSentence()
        self.renderArrow()
        self.renderNavigation()

      @$el
      .on( 'click', '.arrowLeft', -> self.slide('left') )
      .on( 'click', '.arrowRight', -> self.slide('right') )
      .on( 'click', '.slideNaviList', -> self.slide($(@).index()) )
      .on( 'mouseenter', -> self.renderArrow() )
      .on( 'mouseleave', -> self.hideArrow() )

    template: (selector)->
      _.template( @$(selector).html() )
    render: ->
      self = @
      renderSlide = (selector)->
        compileTemplate = self.template(selector)
        outputTemplate = compileTemplate({len: [0..4], image: self.collection.slideDataList.toJSON()})
        self.$(selector).before(outputTemplate)

      renderSlide('#tmp_slideContent')
      renderSlide('#tmp_slideNaviList')

      compileSentence = @template('#tmp_slideDescription')
      sentence = @collection.slideDataList.at(@model.state.get('slideNumber') - 1)
      outputSentence = compileSentence({h2: sentence.get('title'), p: sentence.get('description')})
      @$('#tmp_slideDescription').before(outputSentence)

    renderSentence: ->
      sentence = @collection.slideDataList.at(@model.state.get('slideNumber') - 1)
      $description = @$('.slideDescription')
      $description.find('h2').text(sentence.get('title'))
      $description.find('p').text(sentence.get('description'))

    renderArrow: ->
      @$('.arrowLeft, .arrowRight').addClass('ac')
      switch @model.state.get('slideNumber')
        when 1 then @$('.arrowLeft').removeClass('ac')
        when 5 then @$('.arrowRight').removeClass('ac')

    hideArrow: ->
      @$('.arrowLeft, .arrowRight').removeClass('ac')

    renderNavigation: ->
      num = @model.state.get('slideNumber') - 1
      @$('.slideNaviList')
      .removeClass('ac')
      .eq(num).addClass('ac')

    slide: (toContent)->
      slideWidth = 640
      if @$('.slideContainer').hasClass('sliding') then return false
      if toContent == 'left'
        slideVlue = "+=#{slideWidth}px"
        @model.state.decrease('slideNumber', 1)
      if toContent == 'right'
        slideVlue = "-=#{slideWidth}px"
        @model.state.increase('slideNumber', 1)
      if $.isNumeric(toContent)
        slideVlue = "-#{slideWidth * toContent}px"
        @model.state.set('slideNumber', ++toContent)
      animateStyles =
        marginLeft: slideVlue
      anamateOptions =
        duration: 'normal'
        easing: 'swing'
        complete: -> $(@).removeClass('sliding')
      @$('.slideContainer')
        .addClass('sliding')
        .animate(animateStyles, anamateOptions)

  do ->
    state = new SlideState
    slideDataList = new SlideDataList
    slider = new Slider
      model:
        state: state
      collection:
        slideDataList: slideDataList