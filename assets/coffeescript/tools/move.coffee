window.game.tools.MOVE =
	mouse_down: (e) ->
		if e.clientX > window.game._.canvasPosition.left && e.clientY > window.game._.canvasPosition.top && e.clientX < window.game._.canvasPosition.left + 660 && e.clientY < window.game._.canvasPosition.top + 570
			window.game._.is_mouse_down = true
			window.game.mouse_move(e)
			window.game._.selected_body = window.game.get_body_at_mouse()
			$(document).bind('mousemove', window.game.mouse_move)

	mouse_up: (e) ->
		window.game._.is_mouse_down = false

	mouse_move: (e) ->
		window.game._.mouseX = (e.clientX - window.game._.canvasPosition.left) / 30
		window.game._.mouseY = (e.clientY - window.game._.canvasPosition.top) / 30

	update: () ->
		if window.game._.is_mouse_down && !window.game._.mouse_joint
			body = window.game.get_body_at_mouse()
			if body
				md = new B2MouseJointDef()
				md.bodyA = window.game._.world.GetGroundBody();
				md.bodyB = body;
				md.target.Set(window.game._.mouseX, window.game._.mouseY);
				md.collideConnected = true;
				md.maxForce = 300.0 * body.GetMass();
				window.game._.mouse_joint = window.game._.world.CreateJoint(md);
				body.SetAwake(true);

		if window.game._.mouse_joint
			if window.game._.is_mouse_down
				window.game._.mouse_joint.SetTarget(new B2Vec2(window.game._.mouseX, window.game._.mouseY))
			else
				window.game._.world.DestroyJoint(window.game._.mouse_joint)
				window.game._.mouse_joint = null