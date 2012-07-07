$menus = $('#menus')
$game = $('#game')
$game_cover = $('#game-cover')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')

paused = false;

window.start_game = ->
	

$('.pause').click ->
	window.forward_to($pause_menu)

	$game.addClass('paused');
	$game_cover.show();
	$menus.fadeIn();
	paused = true;
	return false

$('.resume').click ->
	$game.removeClass('paused');
	$game_cover.hide()
	$menus.fadeOut()
	paused = false;
	return false

$('.confirm-exit-game').click ->
	$game_cover.hide()
	$game.fadeOut()

	window.backwards_to($main_menu)