###global Box2D:false, $:false, Math:false###

window.game.components["conveyor-belt"] =
	init: (entity) ->
		entity.moving = []

	update: (entity) ->
		for e in entity.moving
			body = e.fixture.GetBody()
			console.log "MOVE"
			body.ApplyImpulse(new B2Vec2(1000, 0), body.GetWorldCenter())

	begin_contact: (entity, other_entity) ->
		entity.moving.push(other_entity)

	end_contact: (entity, other_entity) ->
		for i in [0...entity.moving.length]
			if entity.moving[i].id == other_entity.id
				entity.moving.splice i, 1
				return