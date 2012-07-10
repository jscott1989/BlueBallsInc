"""
Server side of Blue Balls Inc.
"""

from sys import argv
import os

import bottle
from bottle import get, view, static_file, route

bottle.debug(True)
bottle.reload = True
bottle.TEMPLATE_PATH = ["./templates"]

root_directory = os.path.dirname(os.path.realpath(__file__))

@get('/')
@view("index")
def index():
	# The main page
	return {}

@route('/css/<filepath:path>')
def static_css(filepath):
	return static_file(filepath, root=root_directory + '/static/css/')
@route('/img/<filepath:path>')
def static_img(filepath):
	return static_file(filepath, root=root_directory + '/static/img/')
@route('/js/<filepath:path>')
def static_js(filepath):
	return static_file(filepath, root=root_directory + '/static/js/')

@route('/levels/<level>')
def level(level):
	return static_file(level + '.js', root=root_directory + '/levels/')

bottle.run(host='0.0.0.0', port=argv[1])