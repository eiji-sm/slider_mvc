mainCtrl = ($scope, $rootElement, $http)->
  $scope.slideNumber = 0
  $scope.dataList = demoData  # $http().success()
  $scope.dataLength = $scope.dataList.length - 1
  $scope.dataNumbers = [0..$scope.dataLength]

  _isProcessing = false

  $scope.increase = (model, number = 1)-> if !_isProcessing then $scope[model] += number
  $scope.decrease = (model, number = 1)-> if !_isProcessing then $scope[model] -= number
  $scope.eq = (model, number)-> if !_isProcessing then $scope[model] = number

  $scope.slide = (toContent)->
    if _isProcessing then return
    _isProcessing = true
    _slideWidth = $('.slideContent', $rootElement).width()
    _animateStyles =
      marginLeft: "-#{_slideWidth * toContent}px"
    _anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        _isProcessing = false
    $('.slideContainer', $rootElement).animate(_animateStyles, _anamateOptions)

  $scope.$watch 'slideNumber', (newVal, oldVal)->
    if newVal == oldVal then return
    $scope.slide(newVal)