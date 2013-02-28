mainCtrl = ($scope)->
  $scope.$slider = $('#mainSlider')
  $scope.$content = $('#mainContent')

  $scope.slideNumber = 1
  $scope.isArrowLeft = false
  $scope.isArrowRight = true
  $scope.data = demoData
  $scope.images = [0..($scope.data.length - 1)]

  $scope.isNumber = (number)->
    if $scope.slideNumber == (++number) then 'ac'
  $scope.isFirst = ->
    if $scope.slideNumber != 1 then 'ac'
  $scope.isLast = ->
    if $scope.slideNumber != $scope.data.length then 'ac'

  $scope.slide = (toContent)->
    if $('.slideContainer', $scope.$slider).hasClass('sliding') then return false
    slideWidth = 640
    if toContent == 'left'
      slideVlue = "+=#{slideWidth}px"
      --$scope.slideNumber
    if toContent == 'right'
      slideVlue = "-=#{slideWidth}px"
      ++$scope.slideNumber
    if $.isNumeric(toContent)
      slideVlue = "-#{slideWidth * toContent}px"
      $scope.slideNumber = ++toContent
    animateStyles =
      marginLeft: slideVlue
    anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        $(@).removeClass('sliding')
    $('.slideContainer', $scope.$slider)
      .addClass('sliding')
      .animate(animateStyles, anamateOptions)