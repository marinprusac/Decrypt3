extends TerminalTargetedAbilityData
class_name CrackAbilityData

func _init(cooldown).("Crack", cooldown):
	pass

func use(source: PlayerData, target_terminal: TerminalData, target_port: PortData, password: String):
	if not can_use(source, target_terminal, target_port):
		push_error("Illegal ability.")
	last_target = target_terminal
	start_cooldown()
	
	if password == target_port.password:
		source.known_ports.append(target_port.name)
		var all_there = true
		for port in target_terminal.ports:
			if not port.name in source.known_ports:
				all_there = false
				break
		if all_there:
			return "solved"
		return "equal"
	elif password > target_port.password:
		return "lower"
	else:
		return "higher"
		
