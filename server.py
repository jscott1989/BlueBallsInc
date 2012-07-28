"""
Server side of Blue Balls Inc.
"""

from sys import argv
import os

import bottle
from bottle import get, post, view, static_file, route, redirect, abort, request
from couchdbkit import Server
import json

bottle.debug(True)
bottle.reload = True
bottle.TEMPLATE_PATH = ["./templates"]

root_directory = os.path.dirname(os.path.realpath(__file__))

db_host = os.environ.get('CLOUDANT_URL', "http://localhost:5984")
db = Server(db_host).get_or_create_db("blueballs")

@get('/')
@view("index")
def index():
	# The main page
	return {"level": 1, "auto_load_game": "false", "replay_mode": False}

@post('/replay/new')
def post_replay():
	# Save the replay to the database

	try:
		# We decode then encode to ensure there's nothing bad in it
		replay = {"replay_flag": True, "name": request.POST['name'], "state": json.loads(request.POST['state'])}
	except: # TODO: Exception type
		abort(400, "Invalid state data")

	db.save_doc(replay)
	return redirect('/replay/%s' % replay['_id'])

@get('/replay/:replay_id')
@view("index")
def replay(replay_id):
	if not db.doc_exist(replay_id):
		abort(404, "Replay not found")
	replay = db.get(replay_id)
	if not replay.get('replay_flag'):
		abort(404, "Replay not found")
	return {"level": 1, "auto_load_game": "false", "replay_mode": True, "replay": json.dumps(replay)}

@get('/level/:level_name')
@view("index")
def play_level(level_name):
	# Jump to a particular level
	return {"level": level_name, "auto_load_game": "true", "replay_mode": False}

@route('/css/<filepath:path>')
def static_css(filepath):
	return static_file(filepath, root=root_directory + '/static/css/')
@route('/img/<filepath:path>')
def static_img(filepath):
	return static_file(filepath, root=root_directory + '/static/img/')
@route('/js/<filepath:path>')
def static_js(filepath):
	return static_file(filepath, root=root_directory + '/static/js/')
@route('/sound/<filepath:path>')
def static_sound(filepath):
	return static_file(filepath, root=root_directory + '/static/sound/')

@route('/levels/<level>')
def level(level):
	return static_file(level + '.js', root=root_directory + '/levels/')

bottle.run(host='0.0.0.0', port=argv[1])