extends Resource
class_name GameData

var game_start: float
var game_end: float

var players: Array
var terminals: Array

var settings: Settings

func start_game():
	game_start = Time.get_unix_time_from_system()
	game_end = game_start + settings.game_duration_units * settings.base_time_unit_seconds

func is_game_over():
	var time = Time.get_unix_time_from_system()
	if time >= game_end:
		return true

	for term in terminals:
		if not term.solved:
			return false
	
	return true

func _init(settings: Settings):
	self.settings = settings
	_add_players()
	_add_terminals()


func _add_players():
	players = []

	var player_count = len(settings.player_codes)
	
	var delegated_roles = MyTools.proportional_allocation(player_count, [settings.whitehat_percent, settings.blackhat_percent])
	var delegated_teams = MyTools.proportional_allocation(delegated_roles[0], [settings.red_team_percent, settings.blue_team_percent, settings.yellow_team_percent])
	
	var whitehat_count = delegated_roles[0]
	var blackhat_count = delegated_roles[1]
	var red_count = delegated_teams[0]
	var blue_count = delegated_teams[1]
	var yellow_count = delegated_teams[2]
	
	var player_names: Array = settings.player_codes.keys()
	
	randomize()
	player_names.shuffle()
	
	var roles = MyTools.generate_repeated_elements_array(
		["Blackhat", "Red Team Whitehat", "Blue Team Whitehat", "Yellow Team Whitehat"],
		[blackhat_count, red_count, blue_count, yellow_count])
	
	for i in range(len(player_names)):
		players.append(PlayerData.new(player_names[i], roles[i], settings.ability_cooldown_units * settings.base_time_unit_seconds, settings.expertise_cooldown_units * settings.base_time_unit_seconds))

func _add_terminals():
	terminals = []
	var a_ascii = "A".to_ascii()[0]
	for i in range(settings.terminal_count):
		var name = char(a_ascii + i)
		terminals.append(TerminalData.new(name, settings.ports_per_terminal, settings.digits_per_port))
	
