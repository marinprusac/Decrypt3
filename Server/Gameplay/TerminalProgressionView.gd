extends VBoxContainer


onready var terminal_progress_preload = preload("res://Server/Gameplay/TerminalProgress.tscn")


func initialize(game_data: GameData):
	for child in get_children():
		child.queue_free()
	
	for terminal in game_data.terminals:
		terminal = terminal as TerminalData
		var new_term_instance = terminal_progress_preload.instance()
		new_term_instance.material = new_term_instance.material.duplicate()
		
		var port_count = len(terminal.ports)
		var solved_ports = 0
		for port in terminal.ports:
			if port.solved:
				solved_ports += 1
		
		new_term_instance.max_value = port_count
		new_term_instance.current_value = solved_ports
		new_term_instance.name = terminal.name
		add_child(new_term_instance)

func handle_changes(game_data: GameData):
	for terminal in game_data.terminals:
		terminal = terminal as TerminalData
		var child = get_node(terminal.name)
		var current_value = 0
		for port in terminal.ports:
			if port.solved:
				current_value += 1
		child.set_value(current_value)
		child.set_done(terminal.solved)
		child.set_endangered(not terminal.solved and terminal.endangered)
