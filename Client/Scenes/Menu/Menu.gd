extends Control


signal opened_terminal(terminal_name, crack_mode)
signal opened_info()
signal opened_messages()

signal used_hack(target)
signal used_protect(target)
signal used_scan(target, color)
signal used_crack(terminal, port, pasword)
signal used_sabotage(terminal, port, pasword)
signal used_backdoor(target, color)

var data: KnownData

func enter():
	visible = true

func initialize(data: KnownData):
	var players = data.players
	var terminals = data.terminals
	var player_name = data.name
	var abilities = data.abilities
	$Name.text = data.name
	$Abilities.initialize(data)
	$Players.initialize(data)
	$CenterContainer/Terminals.initialize(data)
	enter()

func _on_disconnected():
	visible = false

func _on_started():
	print("started")

func _on_ended():
	visible = false
	
func refresh():
	$Abilities.refresh()
	$Players.refresh()
	$CenterContainer/Terminals.refresh()

func open_terminal(terminal_name, crack_mode):
	visible = false
	print("Opening terminal ", terminal_name, ". Crack mode: ", crack_mode)
	emit_signal("opened_terminal", terminal_name, crack_mode)

func _on_chosen_terminal(terminal_name, port_index, password):
	$Abilities._on_chosen_terminal(terminal_name, port_index, password)

func open_info():
	visible = false
	emit_signal("opened_info")

func open_messages():
	visible = false
	emit_signal("opened_messages")

func _used_backdoor(target, color):
	emit_signal("used_backdoor", target, color)

func _used_crack(terminal, port, pasword):
	emit_signal("used_crack", terminal, port, pasword)

func _used_hack(target):
	emit_signal("used_hack", target)

func _used_protect(target):
	emit_signal("used_protect", target)

func _used_sabotage(terminal, port, pasword):
	emit_signal("used_sabotage", terminal, port, pasword)

func _used_scan(target, color):
	emit_signal("used_scan", target, color)
