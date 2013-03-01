mainCtrl = ($scope)->
  $scope.$slider = $('#mainSlider')
  $scope.$content = $('#mainContent')

  $scope.slideNumber = 1
  $scope.data = demoData
  $scope.slideLength = [0..($scope.data.length - 1)]

  $scope.increase = (model, number = 1)-> $scope[model] += number
  $scope.decrease = (model, number = 1)-> $scope[model] -= number
  $scope.eq = (model, number)-> $scope[model] = number

  $scope.slide = (toContent)->
    if $('.slideContainer', $scope.$slider).hasClass('sliding') then return false
    slideWidth = $scope.$slider.find('.slideContent').width()
    slideVlue = "-#{slideWidth * toContent}px"
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

  $scope.$watch 'slideNumber', (newValue, oldValue)->
    $scope.slide($scope.slideNumber - 1)