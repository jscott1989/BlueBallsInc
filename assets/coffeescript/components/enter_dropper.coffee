# This will spawn balls and drop them

window.game.components.enter_dropper =
	init: (entity) ->
		entity.balls_created = 0
		entity.last_ball_created = 0
		entity.ball_creation_interval = 100
		return

	update: (entity) ->
		if window.viewModel.state() == 'PLAY'
			entity.last_ball_created += 1

			if entity.last_ball_created > entity.ball_creation_interval
				entity.last_ball_created = 0
				entity.balls_created += 1
				position = entity.fixture.GetBody().GetPosition()
				window.game.create_ball(position.x, position.y + 0.1)