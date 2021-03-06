<div id="game" data-bind="attr: { class: 'tool_' + tool() + ' state_' + state() }">
	<div id="grid">
		<div class="inner">
			<div class="inner2">
				<canvas width="700" height="600" id="gameCanvas"></canvas>
				<canvas width="700" height="600" id="debugCanvas" data-bind="style: {display: debug() ? 'inline' : 'none' }"></canvas>
				<div id="narration" data-bind="style: {display: state() == 'INTRO' ? 'inline' : 'none' }">
					<div class="inner">
						<p data-bind="text: intro_text()"></p>
						<a class="continue">Click to continue</a>
					</div>
				</div>
			</div>
		</div>
	</div><div id="sidebar">
		<div class="inner">
			<div id="level" data-bind="style: {display: replay_mode() ? 'none' : 'block'}, text: 'Level ' + level()"></div>
			<span id="replay_name" data-bind="text: replay_name, style: {display: replay_mode() ? 'block' : 'none'}"></span>
			<button class="start" data-bind="text: isPlaying() ? 'Reset' : 'Start'">Start</button>
			<button class="pause" data-bind="style: {display: replay_mode() ? 'none' : 'block'}">Menu</button>

			<ul id="toolbox" data-bind="foreach: allowed_tools">
				<li data-bind="css: { active: $parent.tool() == $data }, text: $data, attr: {rel: $data}"></li>
			</ul>

			<div id="score">
				<span data-bind="text: balls_complete"></span>/<span data-bind="text: balls_needed"></span>
			</div>

			<label><input type="checkbox" name="sound" data-bind="checked: sound"> Sound</label>
		</div>
	</div>
</div>
<div id="game-cover" data-bind="style: {display: isPaused() || levelOver() ? 'block' : 'none' }">
</div>