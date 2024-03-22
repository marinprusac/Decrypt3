extends AbilityData
class_name PlayerTargetedAbilityData

var last_target = null

func _init(name, cooldown).(name, cooldown):
	pass
	
func is_valid_target(player, target):
	return target != last_target and target != player

func is_team(target, color: String):
	if color == "red" and target.role.begins_with("Red"):
		return true
	if color == "blue" and target.role.begins_with("Blue"):
		return true
	if color == "yellow" and target.role.begins_with("Yellow"):
		return true
	return false

func can_use(player, target):
	return not is_on_cooldown() and is_valid_target(player, target)

func get_dict(player, players):
	var usable_on = []
	for target in players:
		if is_valid_target(player, target):
			usable_on.append(player.name)

	return {
		"start_cooldown": start_cd,
		"end_cooldown": end_cd,
		"usable_on": usable_on
	}
