slider.controller 'mainCtrl', mainCtrl = ($scope, $rootElement, $http, $location)->
  $scope.slideNumber = new numberManager
  $scope.dataList = demoData  # $http().success()
  $scope.dataLength = $scope.dataList.length - 1
  $scope.dataNumbers = [0..$scope.dataLength]

  $location.url($scope.dataList[$scope.slideNumber.val].title)

  $scope.slide = (toContent)->
    $scope.slideNumber.lock()
    _slideWidth = $('.slideContent', $rootElement).width()
    _animateStyles =
      marginLeft: "-#{_slideWidth * toContent}px"
    _anamateOptions =
      duration: 'normal'
      easing: 'swing'
      complete: ->
        $scope.slideNumber.unlock()
        $location.path($scope.dataList[$scope.slideNumber.val].title)
        $scope.$apply()
    $('.slideContainer', $rootElement).animate(_animateStyles, _anamateOptions)

  $scope.$watch 'slideNumber.val', (newVal, oldVal)->
    if newVal == oldVal then return
    $scope.slide(newVal)