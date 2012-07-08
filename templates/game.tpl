<div id="game">
	<div id="grid">
		<div class="inner">
			<div class="inner2">
				<div data-bind="attr: {class: 'grid grid' + difficulty()}">

				</div>
			</div>
		</div>
	</div><div id="sidebar">
		<div class="inner">
			<div class="time">
				<strong>Time</strong>
				<span class="inner" data-bind="text: formatted_time">00:00</span>
			</div>

			<div class="difficulty">
				<strong>Difficulty</strong>
				<span class="inner" data-bind="text: difficulty"></span>
			</div>

			<button class="pause">Pause</button>
		</div>
	</div>
</div>
<div id="game-cover">
</div>