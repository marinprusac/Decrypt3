extends Control

signal opened_terminal(terminal_name, crack_mode)
signal used_ability(ability_name, target_name)
signal opened_info()
signal opened_messages()

func enter():
	visible = true

func initialize(welcome_packet_content: Dictionary):
	var players = welcome_packet_content["players"]
	var terminals = welcome_packet_content["terminals"]
	var player_name = welcome_packet_content["you"]["name"]
	var abilities = welcome_packet_content["you"]["abilities"]
	$Players.initialize(players, player_name)
	$CenterContainer/Terminals.initialize(terminals)
	$Abilities.refresh(abilities)

func _on_disconnected():
	$Abilities.clear()
	$CenterContainer/Terminals.clear()
	$Players.clear()
	visible = false

func refresh_abilities(abilities_packet: Dictionary):
	$Abilities.refresh(abilities_packet)

func refresh_players(players_packet: Dictionary):
	$Players.refresh(players_packet)

func refresh_terminals(terminals_packet: Dictionary):
	$CenterContainer/Terminals.refresh(terminals_packet)

func open_terminal(terminal_name, crack_mode):
	visible = false
	print("Opening terminal ", terminal_name, ". Crack mode: ", crack_mode)
	emit_signal("opened_terminal", terminal_name, crack_mode)
	$Abilities.deselect()

func use_player_ability(ability_name, target_name):
	print("Used ability ", ability_name, " on ", target_name)
	emit_signal("used_ability", ability_name, target_name)
	$Abilities.deselect()
	
func open_info():
	visible = false
	emit_signal("opened_info")

func open_messages():
	visible = false
	emit_signal("opened_messages")
