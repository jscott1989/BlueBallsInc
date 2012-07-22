###global Box2D:false, $:false, Math:false###

window.game.components["conveyor-belt"] =
	init: (entity) ->


	update: (entity) ->

	# begin_contact: (entity, other_entity) ->
	# 	entity.moving.push(other_entity)

	# end_contact: (entity, other_entity) ->
	# 	for i in [0...entity.moving.length]
	# 		if entity.moving[i].id == other_entity.id
	# 			entity.moving.splice i, 1
	# 			return
	# pre_solve: (entity, other_entity, contact) ->
	# 	contact.SetTangentSpeed(5)