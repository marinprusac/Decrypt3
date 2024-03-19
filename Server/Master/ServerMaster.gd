extends Node

var game_data: GameData
var running = false

func _ready():
	var settings = Settings.new()
	
	var players = ["Marin", "Patrik", "Juraj", "Borna", "Mia", "Tin",
	"Jelena", "Mauro", "Silvija", "Lucija", "Luka", "Nika", "Michelle",
	"Lukas", "Matea"]
	
	var codes = MyTools.generate_random_codes(len(players), 3)
	
	var player_dict = {}
	for i in range(len(players)):
		player_dict[players[i]] = codes[i]
	
	settings.player_codes = player_dict
	settings.terminal_count = 5
	settings.ports_per_terminal = 3
	settings.digits_per_port = 2
	
	settings.initial_game_duration_mins = 60
	
	game_data = GameData.new(settings)
	
	$Gameplay.initialize(game_data)

func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		$Gameplay.start()
		running = true
	
	if not running:
		return
	$Gameplay.refresh()
	if game_data.is_game_over():
		running = false
		$Gameplay.end(Time.get_unix_time_from_system() < game_data.game_end)
