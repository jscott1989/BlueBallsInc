preload = (filename) ->
	image = new Image()
	image.src = filename
	image.onload = () ->
		for i in [0...images.length]
			if images[i] == filename
				images.splice i, 1

				if images.length == 0
					window.forward_to($('#main-menu'))
				return



images = [
	"/img/ball.png",
	"/img/metal-ball.png",
	"/img/wheel.png",
	"/img/plank.png",
	"/img/box.png",
	"/img/magnet.png",
	"/img/magnet-beam.png",
	"/img/dry-glue.png",
	"/img/enter_dropper.png",
	"/img/exit_box.png",
	"/img/glue.png"
	"/img/out.png"
	"/img/in.png"
	"/img/xline.png"
	"/img/yline.png"
]

preload(i) for i in images