###global Box2D:false, $:false, Math:false###
# This will spawn balls and drop them

window.game.components.enter_dropper =
	init: (entity) ->
		entity.balls_created = 0

		if not ("ball_order" of entity)
			entity.ball_order = ['ball']

		entity.ball_order_pointer = 0

		if not ("ball_creation_interval" of entity)
			entity.ball_creation_interval = 120

		entity.last_ball_created = entity.ball_creation_interval - 50
		return

	update: (entity) ->
		if window.viewModel.state() == 'PLAY'
			if entity.balls_created < entity.maximum_balls
				entity.last_ball_created += 1

				if entity.last_ball_created > entity.ball_creation_interval
					entity.last_ball_created = 0
					entity.balls_created += 1
					position = entity.fixtures[0].GetBody().GetPosition()

					x = position.x + (Math.random() * 0.2) - 0.1
					y = position.y + 1

					ball_entity =
						"type": entity.ball_order[entity.ball_order_pointer++]
						"x": x
						"y": y
					window.game.create_entity(ball_entity)

					if entity.ball_order_pointer >= entity.ball_order.length
						entity.ball_order_pointer = 0