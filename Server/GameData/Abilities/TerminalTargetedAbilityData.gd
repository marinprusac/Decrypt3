extends AbilityData
class_name TerminalTargetedAbilityData


var last_target = null

func _init(name, cooldown).(name, cooldown):
	pass
	
func can_use(source: PlayerData, target_terminal: TerminalData, target_port: PortData):
	return target_terminal != last_target and not is_on_cooldown() \
	and not target_port.solved and not target_port.name in source.known_ports
