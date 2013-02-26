// Generated by CoffeeScript 1.4.0
var __hasProp={}.hasOwnProperty,__extends=function(e,t){function r(){this.constructor=e}for(var n in t)__hasProp.call(t,n)&&(e[n]=t[n]);r.prototype=t.prototype;e.prototype=new r;e.__super__=t.prototype;return e};$(function(){var e,t,n,r;t=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}__extends(t,e);t.prototype.defaults={slideNumber:1,isArrowLeft:!1,isArrowRight:!0};t.prototype.increase=function(e,t){return this.set(e,this.get(e)+t)};t.prototype.decrease=function(e,t){return this.set(e,this.get(e)-t)};return t}(Backbone.Model);r=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}__extends(t,e);t.prototype.defaulats={url:"",title:"",description:""};return t}(Backbone.Model);e=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}__extends(t,e);t.prototype.url="";t.prototype.initialize=function(){var e,t,n,i,s,o;t=demoData;o=[];for(i=0,s=t.length;i<s;i++){e=t[i];n=new r({url:e.url,title:e.title,description:e.description});o.push(this.add(n))}return o};return t}(Backbone.Collection);n=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}__extends(t,e);t.prototype.el="#wrapper";t.prototype.model={state:{}};t.prototype.collection={slideDataList:{}};t.prototype.initialize=function(){var e;e=this;this.render();this.model.state.bind("change",function(){e.renderSentence();e.renderArrow();return e.renderNavigation()});return this.$el.on("click",".arrowLeft",function(){return e.slide("left")}).on("click",".arrowRight",function(){return e.slide("right")}).on("click",".slideNaviList",function(){return e.slide($(this).index())}).on("mouseenter",function(){return e.renderArrow()}).on("mouseleave",function(){return e.hideArrow()})};t.prototype.template=function(e){return _.template(this.$(e).html())};t.prototype.render=function(){var e,t,n,r,i;r=this;n=function(e){var t,n;t=r.template(e);n=t({len:[0,1,2,3,4],image:r.collection.slideDataList.toJSON()});return r.$(e).before(n)};n("#tmp_slideContent");n("#tmp_slideNaviList");e=this.template("#tmp_slideDescription");i=this.collection.slideDataList.at(this.model.state.get("slideNumber")-1);t=e({h2:i.get("title"),p:i.get("description")});return this.$("#tmp_slideDescription").before(t)};t.prototype.renderSentence=function(){var e,t;t=this.collection.slideDataList.at(this.model.state.get("slideNumber")-1);e=this.$(".slideDescription");e.find("h2").text(t.get("title"));return e.find("p").text(t.get("description"))};t.prototype.renderArrow=function(){this.$(".arrowLeft, .arrowRight").addClass("ac");switch(this.model.state.get("slideNumber")){case 1:return this.$(".arrowLeft").removeClass("ac");case 5:return this.$(".arrowRight").removeClass("ac")}};t.prototype.hideArrow=function(){return this.$(".arrowLeft, .arrowRight").removeClass("ac")};t.prototype.renderNavigation=function(){var e;e=this.model.state.get("slideNumber")-1;return this.$(".slideNaviList").removeClass("ac").eq(e).addClass("ac")};t.prototype.slide=function(e){var t,n,r,i;i=640;if(this.$(".slideContainer").hasClass("sliding"))return!1;if(e==="left"){r="+="+i+"px";this.model.state.decrease("slideNumber",1)}if(e==="right"){r="-="+i+"px";this.model.state.increase("slideNumber",1)}if($.isNumeric(e)){r="-"+i*e+"px";this.model.state.set("slideNumber",++e)}n={marginLeft:r};t={duration:"normal",easing:"swing",complete:function(){return $(this).removeClass("sliding")}};return this.$(".slideContainer").addClass("sliding").animate(n,t)};return t}(Backbone.View);return function(){var r,i,s;s=new t;r=new e;return i=new n({model:{state:s},collection:{slideDataList:r}})}()});