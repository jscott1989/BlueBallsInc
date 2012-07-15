<div id="game" data-bind="attr: { class: 'tool_' + tool() + ' state_' + state() }">
	<div id="grid">
		<div class="inner">
			<div class="inner2">
				<canvas width="700" height="600" id="gameCanvas"></canvas>
				<canvas width="700" height="600" id="debugCanvas" data-bind="style: {display: debug() ? 'inline' : 'none' }"></canvas>
			</div>
		</div>
	</div><div id="sidebar">
		<div class="inner">
			<br /><br />
			<button class="start" data-bind="text: isPlaying() ? 'Reset' : 'Start'">Start</button>
			<br /><br />
			<button class="pause">Menu</button>

			<ul id="toolbox" data-bind="foreach: allowed_tools">
				<li data-bind="css: { active: $parent.tool() == $data }, text: $data, attr: {rel: $data}"></li>
			</ul>

			<div id="score">
				<span data-bind="text: balls_complete"></span>/<span data-bind="text: balls_needed"></span>
			</div>

			<!--<label><input type="checkbox" name="debug" data-bind="checked: debug"> Debug</label>-->
		</div>
	</div>
</div>
<div id="game-cover" data-bind="style: {display: isPaused() ? 'block' : 'none' }">
</div>