###global boxbox:false, $:false###

canvas = $('#gameCanvas')[0]

world = boxbox.createWorld(canvas, {debugDraw:true})

entities = []

window.create_ball = (x, y) ->
	window.ball = world.createEntity({
	    name: 'ball',
	    x: 2,
	    y: 1,
	    shape: "circle",
	    height: 1.5,
	    width: 1.5,
	    fixedRotation: true,
	    friction: 0.3,
	    restitution: 0,
	    color: 'blue',
	    maxVelocityX: 4
	});

window.clear_game = () ->
	entity.destroy for entity in entities