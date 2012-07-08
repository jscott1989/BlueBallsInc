$menus = $('#menus')
$game = $('#game')
$game_cover = $('#game-cover')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')
$time = $('.time .inner')

paused = false;
time = 0;

show_time = ->
	minutes = parseInt(time / 60)
	seconds = parseInt(time % 60)

	if minutes < 10
		minutes = "0" + minutes
	if seconds < 10
		seconds = "0" + seconds

	$time.text(minutes + ":" + seconds)

time_changed = ->
	if !paused
		time += 1
		show_time()

setInterval(time_changed, 1000)

window.start_game = ->
	time = 0
	show_time()
	paused = false

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