mainCtrl = ($scope)->
  $scope.$slider = $('#mainSlider')
  $scope.$content = $('#mainContent')

  $scope.slideNumber = 1
  $scope.isProcessing = false
  $scope.data = demoData
  $scope.slideLength = [0..($scope.data.length - 1)]

  $scope.increase = (model, number = 1)-> if !$scope.isProcessing then $scope[model] += number
  $scope.decrease = (model, number = 1)-> if !$scope.isProcessing then $scope[model] -= number
  $scope.eq = (model, number)-> if !$scope.isProcessing then $scope[model] = number

  $scope.slide = (toContent)->
    if $scope.isProcessing then return false
    $scope.isProcessing = true
    slideWidth = $scope.$slider.find('.slideContent').width()
    slideVlue = "-#{slideWidth * toContent}px"
    animateStyles =
      marginLeft: slideVlue
    anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        $scope.isProcessing = false
    $('.slideContainer', $scope.$slider).animate(animateStyles, anamateOptions)

  $scope.$watch 'slideNumber', (newValue, oldValue)->
    $scope.slide(newValue - 1)