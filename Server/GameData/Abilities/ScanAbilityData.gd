extends PlayerTargetedAbilityData
class_name ScanAbilityData

func _init(cooldown).("Scan", cooldown):
	pass


func use(target: PlayerData, color: String):
	if not can_use(target):
		push_error("Illegal target!")
		return
	last_target = target
	start_cooldown()
	
	if target.has_effect("Protected"):
		return "protected"
	
	if target.has_effect("Hacked"):
		return "no"
	
	if target.has_effect("Clearance") and target.get_effect("Clearance").color == color:
		return "yes"

	if is_team(target, color):
		return "yes"
		
	return "no"
