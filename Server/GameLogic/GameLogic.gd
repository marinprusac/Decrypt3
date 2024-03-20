extends Node

signal initialized(game_data)
signal started()
signal changed(game_data)

var settings: Settings
var game_data: GameData

func initialize(settings: Settings):
	self.settings = settings
	self.game_data = GameData.new(settings)
	emit_signal("initialized", game_data)

func start():
	game_data.start_game()
	emit_signal("started")

func changed():
	emit_signal("changed", game_data)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		start()
