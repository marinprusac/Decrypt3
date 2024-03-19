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
		"Mia": 100,
		"Tin": 100,
		"Jelena": 100,
		"Mauro": 100,
		"Silvija": 100,
		"Lucija": 100,
		"Luka": 100,
		"Nika": 100,
		"Michelle": 100,
		"Lukas": 100,
		"Matea": 100
	}
	settings.terminal_count = 5
	settings.ports_per_terminal = 3
	settings.digits_per_port = 2
	
	gamedata = GameData.new(settings)

	for player in gamedata.players:
		print(player.name, player.role)
