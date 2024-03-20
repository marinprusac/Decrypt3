extends AbilityData
class_name PlayerTargetedAbilityData

var last_target = null

func _init(name, cooldown).(name, cooldown):
	pass
	
func can_use(target: PlayerData):
	return target != last_target and not is_on_cooldown()

func is_protected(target: PlayerData):
	return target.has_effect("Protected")

func is_team(target: PlayerData, color: String):
	if color == "red" and target.role.begins_with("Red"):
		return true
	if color == "blue" and target.role.begins_with("Blue"):
		return true
	if color == "yellow" and target.role.begins_with("Yellow"):
		return true
	return false
