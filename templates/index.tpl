<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Blue Balls Inc.</title>

	<link href='http://fonts.googleapis.com/css?family=Raleway:100' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<div id="container">
		%include game

		<div id="menus">
			%include main_menu
			%include challenge_menu
			%include custom_menu
			%include about_menu
			%include highscore_menu
			%include pause_menu
			%include confirm_exit_menu
		</div>
	</div>

	<script type="text/javascript" src="js/jquery.js"></script>
	<script type='text/javascript' src='js/knockout.js'></script>
	<script type='text/javascript' src='js/box2dweb.js'></script>
	<script type="text/javascript" src="js/main.js"></script>
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