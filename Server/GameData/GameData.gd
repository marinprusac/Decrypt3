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
	
	var reg_cd = settings.base_time_unit_seconds * settings.ability_cooldown_units
	var exp_cd = settings.base_time_unit_seconds * settings.expertise_cooldown_units
	var spc_cd = settings.base_time_unit_seconds * settings.special_cooldown_units
	var clr_d = settings.base_time_unit_seconds * settings.clearance_duration_units
	var frg_d = settings.base_time_unit_seconds * settings.forged_duration_units
	var hck_d = settings.base_time_unit_seconds * settings.hacked_duration_units
	var pro_d = settings.base_time_unit_seconds * settings.protection_duration_units
	
	
	for i in range(len(player_names)):
		var role = roles[i]
		if role == "Blackhat":
			players.append(BlackhatData.new(player_names[i], exp_cd, spc_cd, clr_d, hck_d, frg_d, pro_d))
		elif role == "Red Team Whitehat":
			players.append(RedWhitehatData.new(player_names[i], reg_cd, exp_cd, hck_d, frg_d, pro_d))
		elif role == "Blue Team Whitehat":
			players.append(BlueWhitehatData.new(player_names[i], reg_cd, exp_cd, hck_d, frg_d, pro_d))
		elif role == "Yellow Team Whitehat":
			players.append(YellowWhitehatData.new(player_names[i], reg_cd, exp_cd, hck_d, frg_d, pro_d))

func _add_terminals():
	terminals = []
	var a_ascii = "A".to_ascii()[0]
	for i in range(settings.terminal_count):
		var name = char(a_ascii + i)
		var terminal = TerminalData.new(name, settings.ports_per_terminal, settings.digits_per_port)
		encrypt_terminal(terminal)
		terminals.append(terminal)

func get_player(player_name):
	for player in players:
		if player.name == player_name:
			return player as PlayerData
	return ERR_CANT_ACQUIRE_RESOURCE

func get_terminal(terminal_name):
	for terminal in terminals:
		if terminal.name ==terminal_name:
			return terminal as TerminalData
	return ERR_CANT_ACQUIRE_RESOURCE

func is_sole_unsolved_terminal():
	var unsolved_terminals = 0
	for term in terminals:
		if not term.solved:
			unsolved_terminals = 1
	return unsolved_terminals == 1

func encrypt_terminal(terminal: TerminalData):
	var random_blackhat_known = terminal.ports[randi()%settings.ports_per_terminal]
	terminal.solved = false
	for port in terminal.ports:
		port.solved = false
		port.password = MyTools.generate_random_codes(1, settings.digits_per_port)[0]
		for player in players:
			player.known_ports.erase(port.name)
			if player.role == "Blackhat" and port == random_blackhat_known:
				player.known_ports.append(port.name)

func get_terminals_dict(player: PlayerData):
	var dict = {}
	for terminal in terminals:
		var targetable = is_sole_unsolved_terminal() or player.get_ability("Crack").last_target != terminal.name
		var terminal_dict = terminal.get_dict(targetable, player.known_ports)
		dict[terminal.name] = terminal_dict
	return dict

func get_players_dict(player: PlayerData):
	var dict = {}
	for another in players:
		dict[another.name] = another.get_dict(player)
	return dict
