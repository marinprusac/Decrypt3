extends PlayerTargetedAbilityData
class_name ProtectAbilityData

var protection_duration = null

func _init(cooldown, duration).("Protect", cooldown):
	protection_duration = duration
