extends TerminalTargetedAbilityData
class_name SabotageAbilityData

func _init(cooldown).("Sabotage", cooldown):
	self.cooldown = cooldown

func use(source: PlayerData, game_data: GameData, target_terminal: TerminalData, target_port: PortData, password: String):
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
			game_data.encrypt_terminal(target_terminal)
		return "equal"
	elif password > target_port.password:
		return "lower"
	else:
		return "higher"
