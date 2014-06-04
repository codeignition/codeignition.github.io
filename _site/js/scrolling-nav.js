//jQuery for page scrolling feature - requires jQuery Easing plugin
jQuery(function($){

  $('.page-scroll a').on('click', scroller.hashLinkClicked);
  scroller.loaded();
});

(function($){

  scroller = {
    topScrollOffset: -84,
    scrollTiming: 1000,
    pageLoadScrollDelay: 1000,
    hashLinkClicked: function(e){
      var temp    = window.location.pathname.split('#');
      var curPath = scroller.addTrailingSlash(temp[0]);
      var link       = $(this).attr('href');
      var linkArray  = link.split('#');
      var navId      = (typeof linkArray[1] !== 'undefined') ? linkArray[1] : null;
      var targetPath = scroller.addTrailingSlash(linkArray[0]);
      if (targetPath == curPath && navId) {
        e.preventDefault();
        scroller.scrollToElement('#'+navId);
        window.location.hash = scroller.generateTempNavId(navId);
      } else if (navId) {
        e.preventDefault();
        navId = scroller.generateTempNavId(navId);
        window.location = targetPath+'#'+navId;
      }
    },
    addTrailingSlash: function(str){
      lastChar = str.substring(str.length-1, str.length);
      if (lastChar != '/')
        str = str+'/';
      return str;
    },
    scrollToElement: function(whereTo){
      $.scrollTo(whereTo, scroller.scrollTiming, { offset: { top: scroller.topScrollOffset }, easing: 'easeInOutQuart' });
    },
    generateTempNavId: function(navId){
      return '_'+navId;
    },
    getNavIdFromHash: function(){
      var hash = window.location.hash;

      if (scroller.hashIsTempNavId()) {
        hash = hash.substring(2);
      }

      return hash;
    },
    hashIsTempNavId: function(){
      var hash = window.location.hash;

      return hash.substring(0,2) === '#_';
    },

    scrollToElement: function(whereTo){
      $('html, body').animate({ scrollTop: $(whereTo).offset().top-25 }, scroller.scrollTiming);
    },

    loaded: function(){

      if (scroller.hashIsTempNavId()) {
        setTimeout(function(){scroller.scrollToElement('#'+scroller.getNavIdFromHash());},scroller.pageLoadScrollDelay);
      }
    }
  };

})(jQuery);

setInterval(function() {
  $('.main_unit_text').fadeOut(500, function() {
    var $this = $(this);
    if ($this.text() == 'Awesome ideas needs beautifully written applications') {
      $this.text('Handcrafted infrastructure for beautifully written apps');
    }
    else if ($this.text() == 'Great products deserve smart infrastructure') {
      $this.text('Awesome ideas needs beautifully written applications');
    }
    else      {
      $this.text('Great products deserve smart infrastructure');
    }
    $this.fadeIn(500);
  });
}, 5000);
