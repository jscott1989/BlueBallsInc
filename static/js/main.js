// Generated by CoffeeScript 1.3.3

/* -------------------------------------------- 
     Begin game-main.coffee 
--------------------------------------------
*/


/* -------------------------------------------- 
     Begin menu.coffee 
--------------------------------------------
*/


(function() {
  var $last_active, $menus;

  $menus = $('#menus');

  $last_active = $('.overlay-window.active');

  $('li[data-menu]').live('click', function() {
    var $menu_target, $this, menu_target;
    $this = $(this);
    menu_target = $this.data('menu');
    if (menu_target === 'previous') {
      $menus.animate({
        "left": "+=600px"
      });
      $('.overlay-window.active').removeClass('active');
      $last_active.addClass('active');
      return;
    }
    $menu_target = $(menu_target);
    $('.overlay-window.active').after($menu_target).removeClass('active');
    $menu_target.addClass('active');
    return $menus.animate({
      "left": "-=600px"
    });
  });

}).call(this);
