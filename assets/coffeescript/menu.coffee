$menus = $('#menus')
$last_active = $('.overlay-window.active')

$('li[data-menu]').live 'click', ->
	$this = $(this)
	menu_target = $this.data('menu')

	if menu_target == 'previous'
		$menus.animate({"left": "+=600px"})
		$('.overlay-window.active').removeClass('active')
		$last_active.addClass('active')
		return
	
	$menu_target = $(menu_target)
	$('.overlay-window.active').after($menu_target).removeClass('active')
	$menu_target.addClass('active')
	$menus.animate({"left": "-=600px"})