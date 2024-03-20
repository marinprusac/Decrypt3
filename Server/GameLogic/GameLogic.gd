extends Node

signal initialized(game_data)
signal started()
signal pause_set(paused)
signal ended(winner_exists, whitehat_victory)
signal changed(game_data)

var settings: Settings
var game_data: GameData
var time_paused = null

func initialize(settings: Settings):
	self.settings = settings
	self.game_data = GameData.new(settings)
	emit_signal("initialized", game_data)

func start():
	game_data.start_game()
	emit_signal("started")

func set_pause(paused: bool):
	if paused != (time_paused == null):
		return
	if paused:
		time_paused = Time.get_unix_time_from_system()
	else:
		var time_passed_paused = Time.get_unix_time_from_system() - time_paused
		game_data.game_end = time_passed_paused + game_data.game_end
		changed()
		time_paused = null
	emit_signal("pause_set", paused)
		
func end(winner_exists, whitehat_victory):
	emit_signal("ended", winner_exists, whitehat_victory)

func changed():
	emit_signal("changed", game_data)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		start()
	if Input.is_action_just_pressed("ui_down"):
		end(true, false)
	if Input.is_action_just_pressed("ui_left"):
		set_pause(true)
	if Input.is_action_just_pressed("ui_right"):
		set_pause(false)
