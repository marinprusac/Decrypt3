extends PlayerTargetedAbilityData
class_name ProtectAbilityData

var protection_duration = null

func _init(cooldown, duration).("Protect", cooldown):
	protection_duration = duration

func use(target: PlayerData):
	if not can_use(target):
		push_error("Illegal target!")
		return
	last_target = target
	start_cooldown()
	
	if target.has_effect("Protected"):
		target.get_effect("Protected").end += protection_duration
	else:
		target.effects.append(ProtectedEffectData.new(protection_duration))
