###global SoundJS:false, PreloadJS:false, level:false, auto_load_game: false, replay_mode: false###
preload = (filename) ->
	image = new Image()
	image.src = filename
	image.onload = () ->
		for i in [0...images.length]
			if images[i] == filename
				images.splice i, 1

				if images.length == 0
					if (auto_load_game)
						$('.start-tutorial').click()
					else if replay_mode
						window.viewModel.replay_mode(true)
						window.viewModel.replay_name(window.replay.name)

						$('#menus').hide()
						$('#game').show()
						window.game.load_state window.replay.state, true
						window.viewModel.state("PLAY")
					else
						window.forward_to($('#main-menu'))
				return



images = [
	"/img/ball.png",
	"/img/metal-ball.png",
	"/img/wheel.png",
	"/img/plank.png",
	"/img/box.png",
	"/img/bg.png",
	"/img/ledge.png",
	"/img/magnet.png",
	"/img/magnet-beam.png",
	"/img/dry-glue.png",
	"/img/enter_dropper.png",
	"/img/exit_box.png",
	"/img/glue.png"
	"/img/enter.png"
	"/img/exit.png"
	"/img/in.png"
	"/img/xline.png"
	"/img/yline.png"
	"/img/peg.png"
]

sounds = [
	"ball"
	"collide"
	"menu"
	"start"
]

SoundJS.FlashPlugin.BASE_PATH = "js/"

if not SoundJS.checkPlugin(true)
	console.log("Error initialising sound")

loaded = 0
load_complete = (e) ->
	preload(i) for i in images

queue = new PreloadJS()
queue.installPlugin(SoundJS)
queue.onComplete = load_complete

load_sound = (id) ->
	filename = '/sound/' + id + '.mp3|/sound/' + id + '.ogg'
	item = {
		src:filename,
		id:id
	}
	queue.loadFile(item)

load_sound(s) for s in sounds
queue.load()