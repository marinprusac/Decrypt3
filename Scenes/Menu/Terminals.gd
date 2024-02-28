extends GridContainer


func get_number_of_unsolved_terminals():
	var count = 0
	for terminal in get_children():
		var button: TerminalButton = terminal
		if not button.solved:
			count += 1
	return count

func set_last_used(terminal_name):
	if terminal_name:
		for terminal in get_children():
			var button: TerminalButton = terminal
			button.last_cracked = button.name == terminal_name

func refresh_solved_terminals(terminals_packet):
	for terminal_packet in terminals_packet:
		var terminal: TerminalButton = get_node(terminal_packet["name"])
		terminal.solved = terminal_packet["solved"]
		terminal.disabled = terminal_packet["solved"]
		if terminal_packet["solved"]:
			terminal.modulate = Color(0, 1, 0)


func _on_ability_toggled(pressed, ability_name):
	for terminal in get_children():
		var button: TerminalButton = terminal
		print(pressed, ability_name, get_number_of_unsolved_terminals(), button.last_cracked)
		button.disabled = button.solved or pressed and (ability_name != "Crack" or get_number_of_unsolved_terminals() > 1 and button.last_cracked)
