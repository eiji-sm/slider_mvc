mainCtrl = ($scope, $rootElement, $http, $location)->
  $scope.slideNumber = 0
  $scope.dataList = demoData  # $http().success()
  $scope.dataLength = $scope.dataList.length - 1
  $scope.dataNumbers = [0..$scope.dataLength]

  $location.url($scope.dataList[$scope.slideNumber].title)
  isProcessing = false

  $scope.increase = (model, number = 1)-> if !isProcessing then $scope[model] += number
  $scope.decrease = (model, number = 1)-> if !isProcessing then $scope[model] -= number
  $scope.eq =       (model, number)->     if !isProcessing then $scope[model] =  number

  $scope.slide = (toContent)->
    if isProcessing then return
    isProcessing = true
    _slideWidth = $('.slideContent', $rootElement).width()
    _animateStyles =
      marginLeft: "-#{_slideWidth * toContent}px"
    _anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        isProcessing = false
        $location.path($scope.dataList[$scope.slideNumber].title)
        $scope.$apply()
    $('.slideContainer', $rootElement).animate(_animateStyles, _anamateOptions)

  $scope.$watch 'slideNumber', (newVal, oldVal)->
    if newVal == oldVal then return
    $scope.slide(newVal)