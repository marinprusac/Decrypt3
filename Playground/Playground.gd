extends Node

var settings
var gamedata

func _ready():
	
	settings = Settings.new()
	settings.player_codes = {
		"Marin": 100,
		"Patrik": 100,
		"Juraj": 100,
		"Borna": 100,
		"Mia": 100
	}
	
	gamedata = GameData.new(settings)

	for p in gamedata.players:
		var player = p as PlayerData
		print(player.role)
