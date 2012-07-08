$menus = $('#menus')
$game = $('#game')
$game_cover = $('#game-cover')
$pause_menu = $('#pause-menu')
$main_menu = $('#main-menu')
$time = $('.time .inner')

GameViewModel = ->
	self = this
	self.paused = ko.observable(false)
	self.time = ko.observable(0)
	self.difficulty = ko.observable(3)

	self.minutes = ko.computed ->
		minutes = parseInt(self.time() / 60, 10)
		if minutes < 10
			minutes = "0" + minutes
		return minutes

	self.seconds = ko.computed ->
		seconds = parseInt(self.time() % 60, 10)
		if seconds < 10
			seconds = "0" + seconds
		return seconds

	self.formatted_time = ko.computed ->
		return self.minutes() + ":" + self.seconds()
	return

viewModel = new GameViewModel()
ko.applyBindings(viewModel)

time_changed = ->
	if !viewModel.paused()
		viewModel.time(viewModel.time() + 1)

setInterval(time_changed, 1000)

window.start_game = (difficulty) ->
	viewModel.time(0)
	viewModel.paused(false)
	viewModel.difficulty(difficulty)
	return

$('.pause').click ->
	window.forward_to($pause_menu)

	$game.addClass('paused')
	$game_cover.show()
	$menus.fadeIn()
	viewModel.paused(true)
	return false

$('.resume').click ->
	$game.removeClass('paused')
	$game_cover.hide()
	$menus.fadeOut()
	viewModel.paused(false)
	return false

$('.confirm-exit-game').click ->
	$game_cover.hide()
	$game.fadeOut()

	window.backwards_to($main_menu)