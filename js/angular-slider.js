// Generated by CoffeeScript 1.4.0
var mainCtrl;mainCtrl=function(e){var t,n,r;e.$slider=$("#mainSlider");e.$content=$("#mainContent");e.slideNumber=1;e.isArrowLeft=!1;e.isArrowRight=!0;e.data=demoData;e.images=function(){r=[];for(var t=0,n=e.data.length-1;0<=n?t<=n:t>=n;0<=n?t++:t--)r.push(t);return r}.apply(this);e.isNumber=function(t){if(e.slideNumber===++t)return"ac"};e.isFirst=function(){if(e.slideNumber!==1)return"ac"};e.isLast=function(){if(e.slideNumber!==e.data.length)return"ac"};return e.slide=function(t){var n,r,i,s;if($(".slideContainer",e.$slider).hasClass("sliding"))return!1;s=640;if(t==="left"){i="+="+s+"px";--e.slideNumber}if(t==="right"){i="-="+s+"px";++e.slideNumber}if($.isNumeric(t)){i="-"+s*t+"px";e.slideNumber=++t}r={marginLeft:i};n={duration:"normal",easing:"swing",complete:function(){return $(this).removeClass("sliding")}};return $(".slideContainer",e.$slider).addClass("sliding").animate(r,n)}};