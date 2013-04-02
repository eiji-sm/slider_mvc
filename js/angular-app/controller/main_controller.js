// Generated by CoffeeScript 1.6.1
(function() {
  var mainCtrl;

  slider.controller('mainCtrl', mainCtrl = function($scope, $rootElement, $http, $location) {
    var _i, _ref, _results;
    $scope.slideNumber = new numberManager;
    $scope.dataList = demoData;
    $scope.dataLength = $scope.dataList.length - 1;
    $scope.dataNumbers = (function() {
      _results = [];
      for (var _i = 0, _ref = $scope.dataLength; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this);
    $location.url($scope.dataList[$scope.slideNumber.val].title);
    $scope.slide = function(toContent) {
      var _anamateOptions, _animateStyles, _slideWidth;
      $scope.slideNumber.lock();
      _slideWidth = $('.slideContent', $rootElement).width();
      _animateStyles = {
        marginLeft: "-" + (_slideWidth * toContent) + "px"
      };
      _anamateOptions = {
        duration: 'normal',
        easing: 'swing',
        complete: function() {
          $scope.slideNumber.unlock();
          $location.path($scope.dataList[$scope.slideNumber.val].title);
          return $scope.$apply();
        }
      };
      return $('.slideContainer', $rootElement).animate(_animateStyles, _anamateOptions);
    };
    return $scope.$watch('slideNumber.val', function(newVal, oldVal) {
      if (newVal === oldVal) {
        return;
      }
      return $scope.slide(newVal);
    });
  });

}).call(this);
