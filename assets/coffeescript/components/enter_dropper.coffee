###global Box2D:false, $:false, Math:false###
# This will spawn balls and drop them

window.game.components.enter_dropper =
	init: (entity) ->
		entity.balls_created = 0

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
					position = entity.fixture.GetBody().GetPosition()
					window.game.create_ball(position.x + (Math.random() * 0.2) - 0.1, position.y + 1)