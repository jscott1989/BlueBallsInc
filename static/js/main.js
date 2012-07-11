// Generated by CoffeeScript 1.3.3

/* -------------------------------------------- 
     Begin game.coffee 
--------------------------------------------
*/


/*global ko:false
*/


(function() {
  var $canvas, $game, $last_active, $main_menu, $menus, $pause_menu, B2AABB, B2Body, B2BodyDef, B2CircleShape, B2DebugDraw, B2Fixture, B2FixtureDef, B2MassData, B2MouseJointDef, B2PolygonShape, B2Vec2, B2World, GameViewModel, canvas, canvasPosition, debug_canvas, entities, load_level;

  $menus = $('#menus');

  $game = $('#game');

  $pause_menu = $('#pause-menu');

  $main_menu = $('#main-menu');

  GameViewModel = function() {
    var self;
    self = this;
    self.state = ko.observable("BUILD");
    self.isPaused = ko.computed(function() {
      return self.state() === 'PAUSE';
    });
    self.isPlaying = ko.computed(function() {
      return self.state() === 'PLAY';
    });
  };

  window.viewModel = new GameViewModel();

  ko.applyBindings(window.viewModel);

  load_level = function(level_name) {
    return $.getJSON('/levels/' + level_name, function(data) {
      window.game.load_state(data, true);
      window.viewModel.state("BUILD");
      return window.game.reset();
    });
  };

  window.start_game = function() {
    window.game.refresh_canvas_position();
    load_level("test");
  };

  $('.pause').click(function() {
    window.forward_to($pause_menu);
    $menus.fadeIn();
    window.viewModel.last_state = window.viewModel.state();
    window.viewModel.state("PAUSE");
    return false;
  });

  $('.resume').click(function() {
    $menus.fadeOut();
    window.viewModel.state(window.viewModel.last_state);
    return false;
  });

  $('.start').click(function() {
    if (window.viewModel.state() === "BUILD") {
      return window.viewModel.state("PLAY");
    } else {
      return window.viewModel.state("BUILD");
    }
  });

  $('.confirm-exit-game').click(function() {
    window.viewModel.state("BUILD");
    $game.fadeOut();
    return window.backwards_to($main_menu);
  });

  /* -------------------------------------------- 
       Begin tutorial.coffee 
  --------------------------------------------
  */


  window.start_tutorial = function() {
    return window.start_game(1);
  };

  /* -------------------------------------------- 
       Begin physics.coffee 
  --------------------------------------------
  */


  /*global Box2D:false, $:false
  */


  B2MouseJointDef = Box2D.Dynamics.Joints.b2MouseJointDef;

  B2Vec2 = Box2D.Common.Math.b2Vec2;

  B2AABB = Box2D.Collision.b2AABB;

  B2BodyDef = Box2D.Dynamics.b2BodyDef;

  B2Body = Box2D.Dynamics.b2Body;

  B2FixtureDef = Box2D.Dynamics.b2FixtureDef;

  B2Fixture = Box2D.Dynamics.b2Fixture;

  B2World = Box2D.Dynamics.b2World;

  B2MassData = Box2D.Collision.Shapes.b2MassData;

  B2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape;

  B2CircleShape = Box2D.Collision.Shapes.b2CircleShape;

  B2DebugDraw = Box2D.Dynamics.b2DebugDraw;

  $canvas = $('#gameCanvas');

  canvas = $canvas[0];

  debug_canvas = $('#debugCanvas')[0];

  entities = [];

  canvasPosition = $canvas.offset();

  window.game = {
    _: {
      is_mouse_down: false,
      mouseX: false,
      mouseY: false,
      mouse_joint: false,
      state_changed: function(state) {
        if (state === 'BUILD') {
          return window.game.reset();
        }
      },
      update: function() {
        var offset, position, _ref;
        if (window.game._.is_mouse_down && window.game._.selected_body) {
          position = window.game._.selected_body.GetPosition;
          offset = {
            "x": position.x - window.game._.mouseX,
            "y": position.y - window.game._.mouseY
          };
          if (offset.x !== window.game._.selected_body_offset || offset.y !== window.game._.selected_body_offset) {
            console.log("MOVE");
            console.log(window.game._.mouseX + window.game._.selected_body_offset.x, window.game._.mouseY + window.game._.selected_body_offset.y);
            window.game._.selected_body.SetPosition(window.game._.mouseX + window.game._.selected_body_offset.x, window.game._.mouseY + window.game._.selected_body_offset.y);
          }
          window.game._.selected_body.SetAwake(true);
        }
        if ((_ref = window.viewModel.state()) === 'PAUSE' || _ref === 'BUILD') {
          window.game._.world.DrawDebugData();
          return;
        }
        window.game._.world.Step(1 / 60, 10, 10);
        window.game._.world.DrawDebugData();
        return window.game._.world.ClearForces();
      },
      entities: []
    },
    refresh_canvas_position: function() {
      return canvasPosition = $canvas.offset();
    },
    initialise: function() {
      var debugDraw;
      window.game._.world = new B2World(new B2Vec2(0, 10), true);
      debugDraw = new B2DebugDraw();
      debugDraw.SetSprite(debug_canvas.getContext("2d"));
      debugDraw.SetDrawScale(30);
      debugDraw.SetFillAlpha(0.3);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(B2DebugDraw.e_shapeBit || B2DebugDraw.e_jointBit);
      return window.game._.world.SetDebugDraw(debugDraw);
    },
    create_fixture_def: function(entity) {
      var fixDef;
      fixDef = new B2FixtureDef();
      fixDef.density = entity.density;
      fixDef.friction = entity.friction;
      fixDef.restitution = entity.restitution;
      if (entity.shape.type === "circle") {
        fixDef.shape = new B2CircleShape(entity.shape.size);
      } else if (entity.shape.type === "rectangle") {
        fixDef.shape = new B2PolygonShape();
        fixDef.shape.SetAsBox(entity.shape.size.width, entity.shape.size.height);
      }
      return fixDef;
    },
    create_dynamic_entity: function(entity) {
      var bodyDef, fixDef;
      bodyDef = new B2BodyDef();
      bodyDef.type = B2Body.b2_dynamicBody;
      bodyDef.position.Set(entity.x, entity.y);
      fixDef = window.game.create_fixture_def(entity);
      entity = window.game._.world.CreateBody(bodyDef).CreateFixture(fixDef);
      return window.game._.entities.push(entity);
    },
    create_static_entity: function(entity) {
      var body, bodyDef, fixDef;
      bodyDef = new B2BodyDef();
      bodyDef.type = B2Body.b2_staticBody;
      bodyDef.position.Set(entity.x, entity.y);
      fixDef = window.game.create_fixture_def(entity);
      body = window.game._.world.CreateBody(bodyDef);
      return body.CreateFixture(fixDef);
    },
    load_state: function(state, save_as_default) {
      var entity, _i, _j, _len, _len1, _ref, _ref1, _results;
      if (save_as_default) {
        window.game.default_state = state;
      }
      _ref = state.dynamic;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        window.game.create_dynamic_entity(entity);
      }
      _ref1 = state["static"];
      _results = [];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        entity = _ref1[_j];
        _results.push(window.game.create_static_entity(entity));
      }
      return _results;
    },
    get_state: function() {},
    play: function() {
      return window.game.build_state = window.game.get_state();
    },
    reset: function() {
      var entity, _i, _len, _ref;
      _ref = window.game._.entities;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        window.game._.world.DestroyBody(entity.GetBody());
      }
      window.game._.entities = [];
      return window.game.load_state(window.game.default_state);
    },
    reset_hard: function() {},
    mouse_down: function(e) {
      if (e.clientX > canvasPosition.left && e.clientY > canvasPosition.top && e.clientX < canvasPosition.left + 660 && e.clientY < canvasPosition.top + 570) {
        window.game._.is_mouse_down = true;
        window.game.mouse_move(e);
        window.game._.selected_body = window.game.get_body_at_mouse();
        return $(document).bind('mousemove', window.game.mouse_move);
      }
    },
    mouse_up: function(e) {
      return window.game._.is_mouse_down = false;
    },
    mouse_move: function(e) {
      window.game._.mouseX = (e.clientX - canvasPosition.left) / 30;
      return window.game._.mouseY = (e.clientY - canvasPosition.top) / 30;
    },
    get_body_at_mouse: function() {
      var aabb;
      window.game._.mousePVec = new B2Vec2(window.game._.mouseX, window.game._.mouseY);
      aabb = new B2AABB();
      aabb.lowerBound.Set(window.game._.mouseX - 0.1, window.game._.mouseY - 0.1);
      aabb.upperBound.Set(window.game._.mouseX + 0.1, window.game._.mouseY + 0.1);
      window.game._.selected_body = null;
      window.game._.world.QueryAABB(window.game.get_body_cb, aabb);
      return window.game._.selected_body;
    },
    get_body_cb: function(fixture) {
      var position;
      if (fixture.GetBody().GetType() !== B2Body.b2_staticBody) {
        if (fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), window.game._.mousePVec)) {
          window.game._.selected_body = fixture.GetBody();
          position = window.game._.selected_body.GetPosition();
          window.game._.selected_body_offset = {
            "x": position.x - window.game._.mouseX,
            "y": position.y - window.game._.mouseY
          };
          return false;
        }
      }
      return true;
    }
  };

  $(document).mousedown(window.game.mouse_down);

  $(document).mouseup(window.game.mouse_up);

  window.game.initialise();

  window.setInterval(window.game._.update, 1000 / 60);

  window.viewModel.state.subscribe(window.game._.state_changed);

  /* -------------------------------------------- 
       Begin menu.coffee 
  --------------------------------------------
  */


  $menus = $('#menus');

  $game = $('#game');

  $last_active = $('.overlay-window.active');

  window.forward_to = function($element) {
    $last_active = $('.overlay-window.active');
    if ($last_active.attr('id') === $element.attr('id')) {
      return;
    }
    if ($element.prevAll('.overlay-window.active').length === 0) {
      $menus.css({
        'left': '+=600px'
      });
    }
    $last_active.after($element).removeClass('active');
    $element.addClass('active');
    return $menus.animate({
      "left": "-=600px"
    });
  };

  window.backwards_to = function($element) {
    $last_active = $('.overlay-window.active');
    if ($last_active.attr('id') === $element.attr('id')) {
      return;
    }
    if ($element.prevAll('.overlay-window.active').length > 0) {
      $menus.css({
        'left': '-=600px'
      });
    }
    $last_active.before($element).removeClass('active');
    $element.addClass('active');
    return $menus.animate({
      "left": "+=600px"
    });
  };

  window.show_menu = function(menu_target) {
    var $menu_target;
    if (menu_target === 'previous') {
      window.backwards_to($last_active);
      return;
    }
    $menu_target = $(menu_target);
    return window.forward_to($menu_target);
  };

  $('li[data-menu]').click(function() {
    var $this, menu_target;
    $this = $(this);
    menu_target = $this.data('menu');
    return window.show_menu(menu_target);
  });

  $('.start-tutorial').click(function() {
    $menus.fadeOut();
    $game.fadeIn();
    return window.start_tutorial();
  });

}).call(this);
