<div id="game" data-bind="attr: { class: 'tool_' + tool() }">
	<div id="grid">
		<div class="inner">
			<div class="inner2">
				<canvas width="660" height="570" id="gameCanvas"></canvas>
				<canvas width="660" height="570" id="debugCanvas" data-bind="style: {display: debug() ? 'inline' : 'none' }"></canvas>
			</div>
		</div>
	</div><div id="sidebar">
		<div class="inner">
			<br /><br />
			<button class="start" data-bind="text: isPlaying() ? 'Reset' : 'Start'">Start</button>
			<br /><br />
			<button class="pause">Menu</button>

			<ul id="toolbox">
				<li data-bind="css: { active : tool() == 'MOVE' }" data-tool="MOVE">Move</li>
				<li data-bind="css: { active : tool() == 'GLUE' }" data-tool="GLUE">Glue</li>
				<li data-bind="css: { active : tool() == 'CLEAN' }" data-tool="CLEAN">Clean</li>
			</ul>

			<input type="checkbox" name="debug" data-bind="checked: debug"> Debug
		</div>
	</div>
</div>
<div id="game-cover" data-bind="style: {display: isPaused() ? 'block' : 'none' }">
</div>