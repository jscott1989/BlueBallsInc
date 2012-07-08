<div id="game">
	<div id="grid">
		<div class="inner">
			<div class="inner2">
				<div id="cr-stage">

				</div>
			</div>
		</div>
	</div><div id="sidebar">
		<div class="inner">
			<div class="level stat">
				<strong>Level</strong>
				<span class="inner" data-bind="text: level"></span>
			</div>
			<div class="money stat">
				<strong>Money</strong>
				<span>&pound;</span><span class="inner" data-bind="text: money"></span>
			</div>

			<button class="pause">Pause</button>
		</div>
	</div>
</div>
<div id="game-cover" data-bind="style: {display: paused() ? 'block' : 'none' }">
</div>