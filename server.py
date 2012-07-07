"""
Server side of Blue Balls Inc.
"""

from sys import argv

import bottle
from bottle import get

bottle.debug(True)

@get('/')
def index():
	# The main page
	pass

bottle.run(host='0.0.0.0', port=argv[1])