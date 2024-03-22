extends Node

signal initialized(game_data)
signal started()
signal pause_set(paused)
signal ended(winner_exists, whitehat_victory)
signal changed(game_data)

signal send_welcome(player_name, role, messages, abilities, effects, players, terminals)
signal send_started(player_name)
signal send_paused(player_name, paused)
signal send_ended(player_name, no_winner, victory)
signal send_abilities_refresh(player_name, abilities)
signal send_effects_refresh(player_name, effects)
signal send_terminals_refresh(player_name, terminals)
signal send_players_refresh(player_name, players)
signal send_new_message(player_name, title, content, icon)

var settings: Settings
var game_data: GameData
var running = false
var game_over = false
var time_paused = null

func initialize(settings: Settings):
	self.settings = settings
	self.game_data = GameData.new(settings)
	emit_signal("initialized", game_data)

func start():
	if running or game_over:
		return
	running = true
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
		_on_change()
		time_paused = null
	emit_signal("pause_set", paused)
		
func end(winner_exists, whitehat_victory):
	if not running:
		return
	running = false
	game_over = true
	emit_signal("ended", winner_exists, whitehat_victory)

func _on_change():
	emit_signal("changed", game_data)
	
func _on_hack_used(player_name, target_name):
	pass

func _on_scan_used(player, target, team_color):
	pass

func _on_protect_used(player_name, target_name):
	pass
	
func _on_backdoor_used(player_name, target_name, team_color):
	pass

func _on_crack_used(player_name, terminal_name, port_index, password):
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		start()
	if Input.is_action_just_pressed("ui_down"):
		end(true, false)
	if Input.is_action_just_pressed("ui_left"):
		set_pause(true)
	if Input.is_action_just_pressed("ui_right"):
		set_pause(false)
