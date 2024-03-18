extends Resource
class_name GameData

var game_start = null
var game_end = null
var players = []
var terminals = []

var settings: Settings = null


func _init(settings: Settings):
	self.settings = settings
	_add_players()
	_add_terminals()


func _add_players():
	var player_count = len(settings.player_codes)
	
	var delegated_roles = MyTools.divide_by_ratios(player_count, [settings.whitehat_ratio, settings.blackhat_ratio])
	var delegated_teams = MyTools.divide_by_ratios(delegated_roles[0], [settings.red_team_ratio, settings.blackhat_ratio, settings.yellow_team_ratio])
	
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
		players.append(PlayerData.new(player_names[i], roles[i], settings))
		
func _add_terminals():
	pass
