# The move tool
# Uses a mouse joint to move things around
# TODO: Make this a lot smoother
window.game.tools.MOVE =

	is_mouse_down: false
	mouseX: false
	mouseY: false
	mouse_joint: false

	mouse_down: (e) ->
		if e.clientX > window.physics.canvasPosition.left && e.clientY > window.physics.canvasPosition.top && e.clientX < window.physics.canvasPosition.left + 660 && e.clientY < window.physics.canvasPosition.top + 570
			window.game.tools.MOVE.is_mouse_down = true
			window.game.mouse_move(e)
			window.game.tools.MOVE.selected_body = window.game.tools.MOVE.get_body_at_mouse()
			$(document).bind('mousemove', window.game.mouse_move)

	mouse_up: (e) ->
		window.game.tools.MOVE.is_mouse_down = false

	mouse_move: (e) ->
		window.game.tools.MOVE.mouseX = (e.clientX - window.physics.canvasPosition.left) / 30
		window.game.tools.MOVE.mouseY = (e.clientY - window.physics.canvasPosition.top) / 30

	update: () ->
		if window.game.tools.MOVE.is_mouse_down && !window.game.tools.MOVE.mouse_joint
			body = window.game.tools.MOVE.get_body_at_mouse()
			if body
				md = new B2MouseJointDef()
				md.bodyA = window.physics.world.GetGroundBody();
				md.bodyB = body;
				md.target.Set(window.game.tools.MOVE.mouseX, window.game.tools.MOVE.mouseY);
				md.collideConnected = true;
				md.maxForce = 300.0 * body.GetMass();
				window.game.tools.MOVE.mouse_joint = window.physics.world.CreateJoint(md);
				body.SetAwake(true);

		if window.game.tools.MOVE.mouse_joint
			if window.game.tools.MOVE.is_mouse_down
				window.game.tools.MOVE.mouse_joint.SetTarget(new B2Vec2(window.game.tools.MOVE.mouseX, window.game.tools.MOVE.mouseY))
			else
				window.physics.world.DestroyJoint(window.game.tools.MOVE.mouse_joint)
				window.game.tools.MOVE.mouse_joint = null

	get_body_at_mouse: () ->
		window.game.tools.MOVE.mousePVec = new B2Vec2(window.game.tools.MOVE.mouseX, window.game.tools.MOVE.mouseY)
		aabb = new B2AABB();
		aabb.lowerBound.Set(window.game.tools.MOVE.mouseX - 0.1, window.game.tools.MOVE.mouseY - 0.1)
		aabb.upperBound.Set(window.game.tools.MOVE.mouseX + 0.1, window.game.tools.MOVE.mouseY + 0.1)

		
		window.game.tools.MOVE.selected_body = null
		window.physics.world.QueryAABB(window.game.tools.MOVE.get_body_cb, aabb)
		return window.game.tools.MOVE.selected_body

	get_body_cb: (fixture) ->
		if fixture.GetBody().GetType() != B2Body.b2_staticBody
			if fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), window.game.tools.MOVE.mousePVec)
				window.game.tools.MOVE.selected_body = fixture.GetBody()
				position = window.game.tools.MOVE.selected_body.GetPosition()
				window.game.tools.MOVE.selected_body_offset = {"x": position.x - window.game.tools.MOVE.mouseX, "y": position.y - window.game.tools.MOVE.mouseY}
				return false
		return true