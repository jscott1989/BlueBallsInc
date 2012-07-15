preload = (filename) ->
	image = new Image()
	image.src = filename

images = [
	"img/ball.png",
	"img/box.png",
	"img/dry-glue.png",
	"img/enter_dropper.png",
	"img/exit_box.png",
	"img/glue.png"
	"img/out.png"
	"img/in.png"
	"img/xline.png"
	"img/yline.png"
]

preload(img) for img in images