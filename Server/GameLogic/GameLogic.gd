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
signal send_new_message(player_name, message)

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

func _on_ability_used(player_name, target_name, ability_name):
	var player = game_data.get_player(player_name) as PlayerData
	var target = game_data.get_player(target_name) as PlayerData
	var ability = player.get_ability(ability_name) as AbilityData
	if ability == ERR_CANT_ACQUIRE_RESOURCE:
		push_error("No such ability!")
		return
	if ability.is_on_cooldown():
		return
	if ability.last_target == target_name:
		return
	ability.use(target_name)
	

func _on_crack_used(player_name, terminal_name, port_index, password):
	var player = game_data.get_player(player_name) as PlayerData
	var terminal = game_data.get_terminal(terminal_name) as TerminalData
	var port = terminal.get_port(port_index) as PortData
	var ability = player.get_ability("Crack") as AbilityData
	
	if ability == ERR_CANT_ACQUIRE_RESOURCE:
		push_error("No such ability!")
		return
	if ability.is_on_cooldown():
		return
	if not game_data.is_sole_unsolved_terminal() and ability.last_target == terminal_name:
		return
	ability.use(terminal_name)

func _on_backdoor_used(player_name, target_name, team_color):
	var player = game_data.get_player(player_name) as PlayerData
	var target = game_data.get_player(target_name) as PlayerData
	var ability = player.get_ability("Backdoor") as AbilityData
	if ability == ERR_CANT_ACQUIRE_RESOURCE:
		push_error("No such ability!")
		return
	if ability.is_on_cooldown():
		return
	if ability.last_target == target_name:
		return
	ability.use(target_name)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		start()
	if Input.is_action_just_pressed("ui_down"):
		end(true, false)
	if Input.is_action_just_pressed("ui_left"):
		set_pause(true)
	if Input.is_action_just_pressed("ui_right"):
		set_pause(false)
