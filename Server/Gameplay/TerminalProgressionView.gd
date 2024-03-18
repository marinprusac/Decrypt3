extends VBoxContainer


onready var terminal_progress_preload = preload("res://Server/Gameplay/TerminalProgress.tscn")


func initialize(terminals: Array):
	for child in get_children():
		child.queue_free()
	
	for terminal in terminals:
		var new_term_instance = terminal_progress_preload.instance()
		new_term_instance.terminal_name = terminal.terminal_name
		new_term_instance.current_value = terminal.current_value
		new_term_instance.max_value = terminal.max_value
		new_term_instance.name = terminal.terminal_name
		add_child(new_term_instance)

func update_terminal(terminal):
	var child = get_node(terminal.terminal_name)
