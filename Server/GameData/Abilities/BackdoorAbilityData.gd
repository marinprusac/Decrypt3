extends PlayerTargetedAbilityData
class_name BackdoorAbilityData

var effect_duration = null

func _init(cooldown, effect_duration).("Backdoor", cooldown):
	self.effect_duration = effect_duration

func can_use(target: PlayerData):
	return target != last_target and not is_on_cooldown() and target.get_effect("Backdoored") == null

func use(source: PlayerData, target: PlayerData, color: String):
	if not can_use(target):
		push_error("Illegal target!")
		return
	last_target = target
	
	if is_protected(target):
		return false
	
	for ability in target.abilities:
		ability.cooldown *= 1.2
	for ability in source.abilities:
		ability.cooldown *= 0.9
	
	return true
	
