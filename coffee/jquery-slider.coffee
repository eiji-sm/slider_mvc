$ ->
  $mainSlider = $('#mainSlider')
  $slider = $('.slideContainer', $mainSlider)
  $slideContent = $('.slideContent', $slider)
  slideNaviList = $('.slideNaviList', $mainSlider)
  $slideDescription = $('.slideDescription', '#mainContent')

  slideWidth = $slideContent.width()
  slideLength = $slideContent.length

  slideNumber = 1
  isArrowLeft = false
  isArrowRight = true

  showArrow = ->
    if isArrowLeft then $('.arrowLeft', $mainSlider).addClass('ac')
    if isArrowRight then $('.arrowRight', $mainSlider).addClass('ac')

  hideArrow = ->
    $('.arrowLeft, .arrowRight', $mainSlider).removeClass('ac')

  checkArrowDisplay = ->
    isArrowLeft = slideNumber != 1
    isArrowRight = slideNumber != slideLength
    $mainSlider.trigger('mouseleave')
    $mainSlider.trigger('mouseenter')

  moveActiveClass = ($target)->
    $target.removeClass('ac')
    $target.eq(slideNumber - 1).addClass('ac')

  changeSlideRelations = ->
    moveActiveClass( slideNaviList )
    moveActiveClass( $slideDescription )

  slide = (toContent)->
    if $slider.hasClass('sliding') then return false
    if toContent == 'left'
      slideVlue = "+=#{slideWidth}px"
      --slideNumber
    if toContent == 'right'
      slideVlue = "-=#{slideWidth}px"
      ++slideNumber
    if $.isNumeric(toContent)
      slideVlue = "-#{slideWidth * toContent}px"
      slideNumber = ++toContent
    animateStyles =
      marginLeft: slideVlue
    anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        $(@).removeClass('sliding')
        changeSlideRelations()
        checkArrowDisplay()
    $slider
    .addClass('sliding')
    .animate(animateStyles, anamateOptions)

  $mainSlider
  .on( 'click', '.arrowLeft', -> slide('left') )
  .on( 'click', '.arrowRight', -> slide('right') )
  .on( 'click', '.slideNaviList', -> slide($(@).index()) )
  .on( 'mouseenter', -> showArrow() )
  .on( 'mouseleave', -> hideArrow() )