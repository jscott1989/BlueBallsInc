// Generated by CoffeeScript 1.3.3

/* -------------------------------------------- 
     Begin game-interface.coffee 
--------------------------------------------
*/


/*global ko:false
*/


(function() {
  var $game, $last_active, $main_menu, $menus, $pause_menu, B2AABB, B2Body, B2BodyDef, B2CircleShape, B2ContactListener, B2DebugDraw, B2DistanceJointDef, B2Fixture, B2FixtureDef, B2MassData, B2MouseJointDef, B2PolygonShape, B2RevoluteJointDef, B2Vec2, B2WeldJointDef, B2World, GameViewModel, count, images, img, load_level, preload, _i, _len;

  $menus = $('#menus');

  $game = $('#game');

  $pause_menu = $('#pause-menu');

  $main_menu = $('#main-menu');

  GameViewModel = function() {
    var self;
    self = this;
    self.debug = ko.observable(false);
    self.level = ko.observable("level1");
    self.tool = ko.observable("MOVE");
    self.last_tool = ko.observable("MOVE");
    self.state = ko.observable("BUILD");
    self.isPaused = ko.computed(function() {
      return self.state() === 'PAUSE';
    });
    self.isPlaying = ko.computed(function() {
      return self.state() === 'PLAY';
    });
    self.allowed_tools = ko.observableArray();
    self.balls_complete = ko.observable(0);
    self.balls_needed = ko.observable(0);
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
    window.game.start_game();
    load_level(window.viewModel.level());
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

  $('.confirm-restart-level').click(function() {
    window.viewModel.state("BUILD");
    $menus.fadeOut();
    load_level(window.viewModel.level());
    return window.backwards_to($main_menu);
  });

  $('#toolbox li').live('click', function() {
    window.viewModel.last_tool(window.viewModel.tool());
    return window.viewModel.tool($(this).attr('rel'));
  });

  window.select_last_tool = function() {
    var tmp_tool;
    tmp_tool = window.viewModel.tool();
    window.viewModel.tool(window.viewModel.last_tool());
    return window.viewModel.last_tool(tmp_tool);
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

  B2RevoluteJointDef = Box2D.Dynamics.Joints.b2RevoluteJointDef;

  B2DistanceJointDef = Box2D.Dynamics.Joints.b2DistanceJointDef;

  B2WeldJointDef = Box2D.Dynamics.Joints.b2WeldJointDef;

  B2ContactListener = Box2D.Dynamics.b2ContactListener;

  window.physics = {
    world: new B2World(new B2Vec2(0, 10), true),
    begin_contact: function(contact) {
      var bodyA, bodyB, entityA, entityB, manifold;
      bodyA = contact.GetFixtureA().GetBody();
      bodyB = contact.GetFixtureB().GetBody();
      entityA = window.game.entityIDs[bodyA.userData];
      entityB = window.game.entityIDs[bodyB.userData];
      manifold = contact.GetManifold();
      entityA.touching[entityB.id] = {
        "manifold": manifold
      };
      return entityB.touching[entityA.id] = {
        "manifold": manifold
      };
    },
    end_contact: function(contact) {
      var bodyA, bodyB, entityA, entityB;
      bodyA = contact.GetFixtureA().GetBody();
      bodyB = contact.GetFixtureB().GetBody();
      entityA = window.game.entityIDs[bodyA.userData];
      entityB = window.game.entityIDs[bodyB.userData];
      delete entityA.touching[entityB.id];
      return delete entityB.touching[entityA.id];
    },
    init: function() {
      var debugDraw;
      window.physics.contact_listener = new B2ContactListener();
      window.physics.contact_listener.BeginContact = window.physics.begin_contact;
      window.physics.contact_listener.EndContact = window.physics.end_contact;
      window.physics.world.SetContactListener(window.physics.contact_listener);
      debugDraw = new B2DebugDraw();
      debugDraw.SetSprite(window.game.debug_canvas.getContext("2d"));
      debugDraw.SetDrawScale(30);
      debugDraw.SetFillAlpha(0.3);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(B2DebugDraw.e_shapeBit || B2DebugDraw.e_jointBit);
      return window.physics.world.SetDebugDraw(debugDraw);
    },
    start_game: function() {},
    update: function() {
      if (window.viewModel.state() === 'PAUSE') {
        if (window.viewModel.debug()) {
          window.physics.world.DrawDebugData();
        }
        return;
      }
      window.physics.world.Step(1 / window.game.FPS, 10, 10);
      if (window.viewModel.debug()) {
        window.physics.world.DrawDebugData();
      }
      return window.physics.world.ClearForces();
    },
    create_fixture_def: function(entity) {
      var fixDef, vector, vectors, _i, _len, _ref;
      fixDef = new B2FixtureDef();
      if ("density" in entity.physics) {
        fixDef.density = entity.physics.density;
      }
      if ("friction" in entity.physics) {
        fixDef.friction = entity.physics.friction;
      }
      if ("restitution" in entity.physics) {
        fixDef.restitution = entity.physics.restitution;
      }
      if (entity.physics.shape.type === "circle") {
        fixDef.shape = new B2CircleShape(entity.physics.shape.size);
      } else if (entity.physics.shape.type === "rectangle") {
        fixDef.shape = new B2PolygonShape();
        fixDef.shape.SetAsBox(entity.physics.shape.size.width, entity.physics.shape.size.height);
      } else if (entity.physics.shape.type === "polygon") {
        fixDef.shape = new B2PolygonShape();
        vectors = [];
        _ref = entity.physics.shape.vectors;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          vector = _ref[_i];
          vectors.push(new B2Vec2(vector.x, vector.y));
        }
        fixDef.shape.SetAsArray(vectors);
      }
      return fixDef;
    },
    add_entity: function(entity) {
      var body, bodyDef, fixDef;
      bodyDef = new B2BodyDef();
      if (entity.fixed) {
        bodyDef.type = B2Body.b2_staticBody;
      } else {
        bodyDef.type = B2Body.b2_dynamicBody;
      }
      bodyDef.position.Set(entity.x, entity.y);
      if ('angle' in entity) {
        bodyDef.angle = entity.angle;
      }
      fixDef = window.physics.create_fixture_def(entity);
      body = window.physics.world.CreateBody(bodyDef);
      body.userData = entity.id;
      return entity.fixture = body.CreateFixture(fixDef);
    },
    remove_entity: function(entity) {
      var body;
      body = entity.fixture.GetBody();
      return window.physics.world.DestroyBody(body);
    }
  };

  /* -------------------------------------------- 
       Begin game.coffee 
  --------------------------------------------
  */


  /*global Box2D:false, $:false, Stage:false, Ticker:false, Bitmap:false, Graphics:false, Shape:false
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

  B2RevoluteJointDef = Box2D.Dynamics.Joints.b2RevoluteJointDef;

  B2DistanceJointDef = Box2D.Dynamics.Joints.b2DistanceJointDef;

  B2WeldJointDef = Box2D.Dynamics.Joints.b2WeldJointDef;

  count = 0;

  window.game = {
    tools: {
      _: ""
    },
    bitmaps: {
      glue: new Bitmap("/img/glue.png")
    },
    FPS: 60,
    scale: 30,
    $canvas: $('#gameCanvas'),
    canvas: $('#gameCanvas')[0],
    debug_canvas: $('#debugCanvas')[0],
    canvas_position: {
      "x": 0,
      "y": 0
    },
    canvas_width: 700,
    canvas_height: 600,
    entities: [],
    entityIDs: {},
    walls: [],
    next_id: 1,
    stage: new Stage($('#gameCanvas')[0]),
    last_state: "BUILD",
    last_selected_tool: "MOVE",
    init: function() {
      window.physics.init();
      window.game.stage.update();
      Ticker.setFPS(window.game.FPS);
      return Ticker.addListener(this);
    },
    start_game: function() {
      window.game.refresh_canvas_position();
      return window.physics.start_game();
    },
    refresh_canvas_position: function() {
      return window.game.canvas_position = window.game.$canvas.offset();
    },
    state_changed: function(state) {
      if (state === 'BUILD') {
        if (window.game.last_state !== "PAUSE") {
          window.game.reset();
        }
      } else if (state === 'PLAY') {
        if (window.game.last_state !== "PAUSE") {
          window.game.play();
        }
      }
      return window.game.last_state = state;
    },
    tool_changed: function(new_tool) {
      if ('deselect' in window.game.tools[window.game.last_selected_tool]) {
        window.game.tools[window.game.last_selected_tool].deselect();
      }
      if ('select' in window.game.tools[new_tool]) {
        window.game.tools[new_tool].select();
      }
      return window.game.last_selected_tool = new_tool;
    },
    create_entity: function(entity) {
      var bitmap, component, _i, _len, _ref;
      entity = $.extend(true, {}, window.game.entity_base, window.game.entity_types[entity.type], entity);
      if ("init" in entity) {
        entity.init(entity);
      }
      _ref = entity.components;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        component = _ref[_i];
        window.game.components[component].init(entity);
      }
      if (!entity.id) {
        entity.id = 'entity_' + (window.game.next_id++);
      }
      if (!('bitmaps' in entity)) {
        entity.bitmaps = [];
      }
      if (!('touching' in entity)) {
        entity.touching = {};
      }
      if ('image' in entity) {
        bitmap = new Bitmap("/img/" + entity.image);
        bitmap.regX = bitmap.image.width * 0.5;
        bitmap.regY = bitmap.image.height * 0.5;
        if ("scale" in entity) {
          bitmap.scaleX = entity.scale * entity.scale_adjustment;
          bitmap.scaleY = entity.scale * entity.scale_adjustment;
        }
        entity.bitmaps.push(bitmap);
        window.game.stage.addChild(bitmap);
      }
      window.game.entities.push(entity);
      window.game.entityIDs[entity.id] = entity;
      return window.physics.add_entity(entity);
    },
    create_wall: function(wall) {
      if (wall === "bottom") {
        return window.game.create_entity({
          "type": "xwall",
          "x": 11.5,
          "y": 20
        });
      } else if (wall === "top") {
        return window.game.create_entity({
          "type": "xwall",
          "x": 11.5,
          "y": -0
        });
      } else if (wall === "left") {
        return window.game.create_entity({
          "type": "ywall",
          "x": -0,
          "y": 10
        });
      } else if (wall === "right") {
        return window.game.create_entity({
          "type": "ywall",
          "x": 23.2,
          "y": 10
        });
      }
    },
    load_state: function(state, save_as_default) {
      var entity, tool, wall, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
      window.game.clear_entities();
      if (save_as_default) {
        window.game.default_state = state;
        window.game.build_state = state;
      }
      if (state.entities) {
        _ref = state.entities;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          entity = _ref[_i];
          window.game.create_entity(entity);
        }
      }
      window.game.settings = state.settings;
      window.viewModel.allowed_tools.removeAll();
      _ref1 = window.game.settings.tools;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        tool = _ref1[_j];
        window.viewModel.allowed_tools.push(tool);
      }
      window.game.walls = state.walls;
      _ref2 = window.game.walls;
      _results = [];
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        wall = _ref2[_k];
        _results.push(window.game.create_wall(wall));
      }
      return _results;
    },
    clean_entity: function(entity) {
      var position;
      entity = $.extend(true, {}, entity);
      entity.physics.density = entity.fixture.m_density;
      entity.physics.friction = entity.fixture.m_friction;
      entity.physics.restitution = entity.fixture.m_restitution;
      position = entity.fixture.GetBody().GetPosition();
      entity.x = position.x;
      entity.y = position.y;
      entity.angle = entity.fixture.GetBody().GetAngle();
      delete entity.bitmaps;
      delete entity.touching;
      delete entity.fixture;
      delete entity.init;
      return entity;
    },
    get_state: function() {
      var entity, state;
      state = {
        "walls": [],
        "settings": window.game.settings
      };
      state.entities = (function() {
        var _i, _len, _ref, _results;
        _ref = window.game.entities;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          entity = _ref[_i];
          _results.push(window.game.clean_entity(entity));
        }
        return _results;
      })();
      return state;
    },
    play: function() {
      return window.game.build_state = window.game.get_state();
    },
    remove_entity: function(entity) {
      var bitmap, _i, _len, _ref;
      if ("bitmaps" in entity) {
        _ref = entity.bitmaps;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          bitmap = _ref[_i];
          window.game.stage.removeChild(bitmap);
        }
      }
      return window.physics.remove_entity(entity);
    },
    clear_entities: function() {
      var entity, _i, _len, _ref;
      _ref = window.game.entities;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        window.game.remove_entity(entity);
      }
      window.game.entities = [];
      return window.game.entityIDs = [];
    },
    reset: function() {
      return window.game.load_state(window.game.build_state);
    },
    reset_level: function() {
      return window.game.load_state(window.game.default_state);
    },
    meters_to_pixels: function(meters) {
      return meters * window.game.scale;
    },
    pixels_to_meters: function(pixels) {
      return pixels / window.game.scale;
    },
    degrees_to_radians: function(degrees) {
      return degrees * 0.0174532925199432957;
    },
    radians_to_degrees: function(radians) {
      return radians * 57.295779513082320876;
    },
    update_position: function(entity) {
      var bitmap, position, _i, _len, _ref, _results;
      if ("bitmaps" in entity) {
        position = entity.fixture.GetBody().GetPosition();
        _ref = entity.bitmaps;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          bitmap = _ref[_i];
          bitmap.x = window.game.meters_to_pixels(position.x);
          bitmap.y = window.game.meters_to_pixels(position.y);
          _results.push(bitmap.rotation = window.game.radians_to_degrees(entity.fixture.GetBody().GetAngle()));
        }
        return _results;
      }
    },
    update_positions: function() {
      var entity, _i, _len, _ref, _results;
      _ref = window.game.entities;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        _results.push(window.game.update_position(entity));
      }
      return _results;
    },
    tick: function() {
      var component, entity, _i, _j, _len, _len1, _ref, _ref1;
      window.game.tools[window.viewModel.tool()].update();
      _ref = window.game.entities;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        _ref1 = entity.components;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          component = _ref1[_j];
          window.game.components[component].update(entity);
        }
      }
      window.physics.update();
      window.game.update_positions();
      return window.game.stage.update();
    },
    mouse_down: function(e) {
      if (window.viewModel.state() === 'BUILD') {
        if (e.clientX > window.game.canvas_position.left && e.clientY > window.game.canvas_position.top && e.clientX < window.game.canvas_position.left + window.game.canvas_width && e.clientY < window.game.canvas_position.top + window.game.canvas_height) {
          window.game.mouse_down = true;
          if ('mouse_down' in window.game.tools[window.viewModel.tool()]) {
            return window.game.tools[window.viewModel.tool()].mouse_down(e);
          }
        }
      }
    },
    mouse_up: function(e) {
      if (window.viewModel.state() === 'BUILD') {
        window.game.mouse_down = false;
        if ('mouse_up' in window.game.tools[window.viewModel.tool()]) {
          return window.game.tools[window.viewModel.tool()].mouse_up(e);
        }
      }
    },
    mouse_move: function(e) {
      if (window.viewModel.state() === 'BUILD') {
        window.game.mouseX = (e.clientX - window.game.canvas_position.left) / window.game.scale;
        window.game.mouseY = (e.clientY - window.game.canvas_position.top) / window.game.scale;
        if ('mouse_move' in window.game.tools[window.viewModel.tool()]) {
          return window.game.tools[window.viewModel.tool()].mouse_move(e);
        }
      }
    },
    get_entity_at_mouse: function() {
      var aabb, get_body_cb, mousePVec, selected_body;
      mousePVec = new B2Vec2(window.game.mouseX, window.game.mouseY);
      aabb = new B2AABB();
      aabb.lowerBound.Set(window.game.mouseX - 0.1, window.game.mouseY - 0.1);
      aabb.upperBound.Set(window.game.mouseX + 0.1, window.game.mouseY + 0.1);
      selected_body = null;
      get_body_cb = function(fixture) {
        if (fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), mousePVec)) {
          selected_body = fixture.GetBody();
          return false;
        }
        return true;
      };
      window.physics.world.QueryAABB(get_body_cb, aabb);
      if (selected_body) {
        return window.game.entityIDs[selected_body.userData];
      }
    },
    get_offset_to_mouse: function(entity) {
      var body, mouse_position, position, rotated_position;
      body = entity.fixture.GetBody();
      position = body.GetPosition();
      mouse_position = {
        "x": window.game.mouseX,
        "y": window.game.mouseY
      };
      rotated_position = window.game.rotate_point(mouse_position, position, 0 - body.GetAngle());
      return {
        "x": position.x - rotated_position.x,
        "y": position.y - rotated_position.y
      };
    },
    rotate_point: function(point, origin, angle) {
      var c, s, xnew, ynew;
      s = Math.sin(angle);
      c = Math.cos(angle);
      point.x -= origin.x;
      point.y -= origin.y;
      xnew = point.x * c - point.y * s;
      ynew = point.x * s + point.y * c;
      point.x = xnew + origin.x;
      point.y = ynew + origin.y;
      return point;
    },
    create_ball: function(x, y) {
      var entity;
      entity = {
        "type": "ball",
        "x": x,
        "y": y
      };
      return window.game.create_entity(entity);
    }
  };

  $(document).mousedown(window.game.mouse_down);

  $(document).mouseup(window.game.mouse_up);

  $(document).mousemove(window.game.mouse_move);

  window.game.init();

  window.viewModel.state.subscribe(window.game.state_changed);

  window.viewModel.tool.subscribe(window.game.tool_changed);

  /* -------------------------------------------- 
       Begin tools.coffee 
  --------------------------------------------
  */


  /* -------------------------------------------- 
       Begin move.coffee 
  --------------------------------------------
  */


  window.game.tools.MOVE = {
    mouse_joint: false,
    update: function() {
      var body, entity, md;
      if (window.game.mouse_down && !window.game.tools.MOVE.mouse_joint) {
        entity = window.game.get_entity_at_mouse();
        if (entity) {
          body = entity.fixture.GetBody();
          md = new B2MouseJointDef();
          md.bodyA = window.physics.world.GetGroundBody();
          md.bodyB = body;
          md.target.Set(window.game.mouseX, window.game.mouseY);
          md.collideConnected = true;
          md.maxForce = 300.0 * body.GetMass();
          window.game.tools.MOVE.mouse_joint = window.physics.world.CreateJoint(md);
          body.SetAwake(true);
        }
      }
      if (window.game.tools.MOVE.mouse_joint) {
        if (window.game.mouse_down) {
          return window.game.tools.MOVE.mouse_joint.SetTarget(new B2Vec2(window.game.mouseX, window.game.mouseY));
        } else {
          window.physics.world.DestroyJoint(window.game.tools.MOVE.mouse_joint);
          return window.game.tools.MOVE.mouse_joint = null;
        }
      }
    }
  };

  /* -------------------------------------------- 
       Begin glue.coffee 
  --------------------------------------------
  */


  window.game.tools.GLUE = {
    mouse_is_down: false,
    select: function() {},
    deselect: function() {},
    mouse_down: function(e) {
      return window.game.tools.GLUE.mouse_is_down = true;
    },
    mouse_up: function(e) {
      return window.game.tools.GLUE.mouse_is_down = false;
    },
    update: function() {
      var entity, offset;
      if (window.game.tools.GLUE.mouse_is_down) {
        entity = window.game.get_entity_at_mouse();
        if (entity) {
          offset = window.game.get_offset_to_mouse(entity);
          return entity.add_glue(offset);
        }
      }
    }
  };

  /* -------------------------------------------- 
       Begin clean.coffee 
  --------------------------------------------
  */


  window.game.tools.CLEAN = {
    update: function() {
      var entity, offset;
      if (window.game.mouse_down) {
        entity = window.game.get_entity_at_mouse();
        if (entity) {
          offset = window.game.get_offset_to_mouse(entity);
          return entity.clean_glue(offset);
        }
      }
    }
  };

  /* -------------------------------------------- 
       Begin entities.coffee 
  --------------------------------------------
  */


  window.game.entity_types = {};

  window.game.entity_base = {
    scale: 1,
    components: ["gluable"]
  };

  /* -------------------------------------------- 
       Begin ball.coffee 
  --------------------------------------------
  */


  window.game.entity_types.ball = {
    name: "Ball",
    image: "ball.png",
    width_scale: 1,
    height_scale: 1,
    scale_adjustment: 0.5,
    physics: {
      density: 40,
      friction: 2,
      restitution: 0.5,
      shape: {
        type: "circle",
        size: 1
      }
    },
    init: function() {
      this.physics.shape.size.width = this.scale_adjustment * this.width_scale * this.scale;
      return this.physics.shape.size.height = this.scale_adjustment * this.height_scale * this.scale;
    }
  };

  /* -------------------------------------------- 
       Begin box.coffee 
  --------------------------------------------
  */


  window.game.entity_types.box = {
    name: "Box",
    image: "box.png",
    width_scale: 6,
    height_scale: 6,
    scale_adjustment: 0.2,
    physics: {
      density: 40,
      friction: 2,
      restitution: 0.2,
      shape: {
        type: "rectangle",
        size: {
          width: 6,
          height: 6
        }
      }
    },
    init: function() {
      this.physics.shape.size.width = this.scale_adjustment * this.width_scale * this.scale;
      return this.physics.shape.size.height = this.scale_adjustment * this.height_scale * this.scale;
    }
  };

  /* -------------------------------------------- 
       Begin dropper.coffee 
  --------------------------------------------
  */


  window.game.entity_types.enter_dropper = {
    name: "Ball Dropper",
    image: "enter_dropper.png",
    width_scale: 2,
    height_scale: 2,
    fixed: true,
    scale_adjustment: 1,
    scale: 0.5,
    physics: {
      density: 40,
      friction: 2,
      restitution: 0.2,
      shape: {
        type: "rectangle",
        size: {
          width: 6,
          height: 6
        }
      }
    },
    init: function(entity) {
      entity.physics.shape.size.width = entity.scale_adjustment * entity.width_scale * entity.scale;
      entity.physics.shape.size.height = entity.scale_adjustment * entity.height_scale * entity.scale;
      return entity.components.push('enter_dropper');
    }
  };

  /* -------------------------------------------- 
       Begin box.coffee 
  --------------------------------------------
  */


  window.game.entity_types.exit_box = {
    name: "Box",
    image: "exit_box.png",
    width_scale: 2,
    height_scale: 2,
    scale_adjustment: 0.5,
    fixed: true,
    physics: {
      density: 40,
      friction: 2,
      restitution: 0.2,
      shape: {
        type: "rectangle",
        size: {
          width: 6,
          height: 6
        }
      }
    },
    init: function() {
      this.physics.shape.size.width = this.scale_adjustment * this.width_scale * this.scale;
      return this.physics.shape.size.height = this.scale_adjustment * this.height_scale * this.scale;
    }
  };

  /* -------------------------------------------- 
       Begin walls.coffee 
  --------------------------------------------
  */


  window.game.entity_types.xwall = {
    name: "Wall",
    fixed: true,
    "physics": {
      "shape": {
        "type": "rectangle",
        "size": {
          "width": 11.5,
          "height": 0.1
        }
      }
    }
  };

  window.game.entity_types.ywall = {
    name: "Wall",
    fixed: true,
    "physics": {
      "shape": {
        "type": "rectangle",
        "size": {
          "width": 0.1,
          "height": 10
        }
      }
    }
  };

  /* -------------------------------------------- 
       Begin components.coffee 
  --------------------------------------------
  */


  window.game.components = {};

  /* -------------------------------------------- 
       Begin gluable.coffee 
  --------------------------------------------
  */


  window.game.components.gluable = {
    init: function(entity) {
      entity.glue = [];
      entity.add_glue = function(offset) {
        var bitmap;
        bitmap = window.game.bitmaps.glue.clone();
        bitmap.regX = window.game.meters_to_pixels(offset.x) + (bitmap.image.width / 2);
        bitmap.regY = window.game.meters_to_pixels(offset.y) + (bitmap.image.width / 2);
        entity.bitmaps.push(bitmap);
        entity.glue.push({
          "x": offset.x,
          "y": offset.y,
          "bitmap": bitmap
        });
        return window.game.stage.addChild(bitmap);
      };
      return entity.clean_glue = function(offset) {
        var glue, glue_to_remove, idx, max_x, max_y, min_x, min_y, _i, _j, _len, _len1, _ref, _results;
        min_x = offset.x - 0.2;
        max_x = offset.x + 0.2;
        min_y = offset.y - 0.2;
        max_y = offset.y + 0.2;
        glue_to_remove = [];
        _ref = entity.glue;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          glue = _ref[_i];
          if (glue.x > min_x && glue.x < max_x && glue.y > min_y && glue.y < max_y) {
            glue_to_remove.push(glue);
          }
        }
        _results = [];
        for (_j = 0, _len1 = glue_to_remove.length; _j < _len1; _j++) {
          glue = glue_to_remove[_j];
          window.game.stage.removeChild(glue.bitmap);
          idx = entity.glue.indexOf(glue);
          if (idx !== -1) {
            entity.glue.splice(idx, 1);
          }
          idx = entity.bitmaps.indexOf(glue.bitmap);
          if (idx !== -1) {
            _results.push(entity.bitmaps.splice(idx, 1));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
    },
    update: function(entity) {}
  };

  /* -------------------------------------------- 
       Begin enter_dropper.coffee 
  --------------------------------------------
  */


  window.game.components.enter_dropper = {
    init: function(entity) {
      entity.balls_created = 0;
      if (!("ball_creation_interval" in entity)) {
        entity.ball_creation_interval = 400;
      }
      entity.last_ball_created = entity.ball_creation_interval - 50;
    },
    update: function(entity) {
      var position;
      if (window.viewModel.state() === 'PLAY') {
        if (entity.balls_created < entity.maximum_balls) {
          entity.last_ball_created += 1;
          if (entity.last_ball_created > entity.ball_creation_interval) {
            entity.last_ball_created = 0;
            entity.balls_created += 1;
            position = entity.fixture.GetBody().GetPosition();
            return window.game.create_ball(position.x, position.y + 0.1);
          }
        }
      }
    }
  };

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
    return window.start_game();
  });

  /* -------------------------------------------- 
       Begin preload.coffee 
  --------------------------------------------
  */


  preload = function(filename) {
    var image;
    image = new Image();
    return image.src = filename;
  };

  images = ["img/ball.png", "img/box.png", "img/dry-glue.png", "img/enter_dropper.png", "img/exit_box.png", "img/glue.png"];

  for (_i = 0, _len = images.length; _i < _len; _i++) {
    img = images[_i];
    preload(img);
  }

}).call(this);
