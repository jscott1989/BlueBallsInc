$menus = $('#menus')
$game = $('#game')
$last_active = $('.overlay-window.active')

window.forward_to = ($element) ->
	$last_active = $('.overlay-window.active')

	if $last_active.attr('id') == $element.attr('id')
		return

	if $element.prevAll('.overlay-window.active').length == 0
		$menus.css({'left': '+=600px'})

	$last_active.after($element).removeClass('active')
	$element.addClass('active')
	$menus.animate({"left": "-=600px"})

window.backwards_to = ($element) ->
	$last_active = $('.overlay-window.active')
	
	if $last_active.attr('id') == $element.attr('id')
		return
		
	if $element.prevAll('.overlay-window.active').length > 0
		$menus.css({'left': '-=600px'})

	$last_active.before($element).removeClass('active')
	$element.addClass('active')
	$menus.animate({"left": "+=600px"})


window.show_menu = (menu_target) ->
	if menu_target == 'previous'
		window.backwards_to($last_active)
		return

	$menu_target = $(menu_target)
	window.forward_to($menu_target)


$('li[data-menu]').click ->
	# Allow moving through the menus
	$this = $(this)
	menu_target = $this.data('menu')

	window.show_menu(menu_target)

$('.start-tutorial').click ->
	# Start tutorial mode
	$menus.fadeOut()
	$game.fadeIn()
	window.start_game()