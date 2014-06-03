//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
  $('.page-scroll a').bind('click', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href').split("/")[1]).offset().top-25
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
});

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
