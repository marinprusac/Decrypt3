extends TextureRect

var safe_color = Vector3(.25,.75,.25)
var trouble_color = Vector3(.75,.25,.25)

var running = false
var chance = 0.5
var interpolating_chance = 1

var base_unit = 0
var initial_time = 0
var time_end = 0
var time_increment = 0
var unsolved_ports = []

func initialize(game_data: GameData):
	chance = 0.5
	base_unit = game_data.settings.base_time_unit_seconds
	interpolating_chance = 1
	initial_time = game_data.settings.base_time_unit_seconds * game_data.settings.game_duration_units
	time_increment = game_data.settings.base_time_unit_seconds * game_data.settings.game_duration_increment_units
	handle_changes(game_data)

func start():
	time_end = Time.get_unix_time_from_system() + initial_time
	running = true

func end(victory):
	running = false
	material.set("shader_param/color", safe_color if victory else trouble_color)


func handle_changes(game_data: GameData):
	time_end = game_data.game_end
	unsolved_ports = []
	for terminal in game_data.terminals:
		if not terminal.solved:
			var count_unsolved = 0
			for port in terminal.ports:
				if not port.solved:
					count_unsolved += 1
			unsolved_ports.append(count_unsolved)



func _process(delta):
	if not running:
		return
	
	var now = Time.get_unix_time_from_system()
	var time_left = (time_end - now)
	chance = MyTools.calculate_win_chance(unsolved_ports, 4.5*base_unit, time_left, time_increment)
	
	var factor = 0.2
	interpolating_chance = lerp(interpolating_chance, chance, 1-pow(1-factor,delta))
	
	var rotation = -(interpolating_chance-1) * 1000
	
	var chance_color = lerp(trouble_color, safe_color, pow(interpolating_chance,5))
	var delta_color = safe_color if chance-interpolating_chance > 0 else trouble_color
	
	var color = lerp(chance_color, delta_color, abs(chance-interpolating_chance)*10)
	
	material.set("shader_param/rotation", rotation)
	material.set("shader_param/color", color)
