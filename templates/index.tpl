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
	<script type="text/javascript" src="js/main.js"></script>
</body>
</html>