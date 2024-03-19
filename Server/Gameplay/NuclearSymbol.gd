extends TextureRect

var neutral_color = Vector3(.5, .5, .5)
var safe_color = Vector3(.25,.75,.25)
var trouble_color = Vector3(.75,.25,.25)

var running = false
var rotation = 0.0
var chance = 0.5
var interpolating_chance = 1

func start():
	running = true
	chance = 0.5
	interpolating_chance = 1

func end(victory):
	running = false
	material.set("shader_param/color", safe_color if victory else trouble_color)



func refresh(game_data: GameData):
	var now = Time.get_unix_time_from_system()
	var time_left = (game_data.game_end - now)
	var time_increment = game_data.settings.game_duration_increment_mins*60
	
	
	var unsolved_ports_per_terminal = []
	
	for terminal in game_data.terminals:
		if not terminal.solved:
			var unsolved_ports = 0
			for port in terminal.ports:
				if not port.solved:
					unsolved_ports += 1
			unsolved_ports_per_terminal.append(unsolved_ports)
	
	chance = MyTools.calculate_win_chance(unsolved_ports_per_terminal, 4.5*60, time_left, time_increment)
	print(chance)

func _process(delta):
	if not running:
		return
	
	var factor = 0.2
	interpolating_chance = lerp(interpolating_chance, chance, 1-pow(1-factor,delta))
	
	rotation = -(interpolating_chance-1) * 1000
	
	var chance_color = lerp(trouble_color, safe_color, pow(interpolating_chance,5))
	var delta_color = safe_color if chance-interpolating_chance > 0 else trouble_color
	
	var color = lerp(chance_color, delta_color, abs(chance-interpolating_chance)*10)
	
	material.set("shader_param/rotation", rotation)
	material.set("shader_param/color", color)
