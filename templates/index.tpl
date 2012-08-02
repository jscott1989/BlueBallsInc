<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Blue Balls Inc.</title>

	<link href='http://fonts.googleapis.com/css?family=Raleway:100' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<body>
	<div id="container">
		%include game

		<div id="menus">
			%include loading_menu
			%include main_menu
			%include challenge_menu
			%include custom_menu
			%include about_menu
			%include highscore_menu
			%include pause_menu
			%include confirm_exit_menu
			%include confirm_restart_menu
			%include level_complete_menu
			%include replay_complete_menu
			%include watch_replay_menu
			%include end_game_menu
		</div>
	</div>

	<form id="replay-form" action="/replay/new" method="POST" style="display: none" target="_BLANK">
		<input type="text" name="name" data-bind="value: name">
		<input type="text" name="state" data-bind="value: build_state_string()">
		<input type="submit">
	</form>
	
	<script type="text/javascript">auto_load_game = {{auto_load_game}}; level = {{level}}; replay_mode = false;</script>
	% if replay_mode:
		<script type="text/javascript">
			replay_mode = true;
			window.replay = {{!replay}};
		</script>
	%end
	<script type='text/javascript' src='/js/preloadjs.js'></script>
	<script type='text/javascript' src='/js/soundjs.js'></script>
	<script type='text/javascript' src='/js/soundjs.flash.js'></script>
	<script type="text/javascript" src="/js/jquery.js"></script>
	<script type='text/javascript' src='/js/knockout.js'></script>
	<script type='text/javascript' src='/js/box2dweb.js'></script>
	<script type='text/javascript' src='/js/easeljs.js'></script>
	<script type="text/javascript" src="/js/seedrandom.js"></script>
	<script type="text/javascript" src="/js/main.js"></script>
	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-13066747-1']);
		_gaq.push(['_setDomainName', 'jscott.me']);
		_gaq.push(['_setAllowLinker', true]);
		_gaq.push(['_trackPageview']);

		(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
	</script>
</body>
</html>