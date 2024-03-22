extends AbilityData
class_name TerminalTargetedAbilityData
var last_target = null

func _init(name, cooldown).(name, cooldown):
	pass
	
func is_valid_target(terminal):
	return terminal != last_target

func can_use(player, terminal, port):
	return is_valid_target(terminal) and not port.solved and not port.name in player.known_portsa and not is_on_cooldown()

func get_dict(player, terminals):
	var usable_on = []
	for terminal in terminals:
		if is_valid_target(terminal):
			usable_on.append(terminal.name)

	return {
		"start_cooldown": start_cd,
		"end_cooldown": end_cd,
		"usable_on": usable_on
	}
