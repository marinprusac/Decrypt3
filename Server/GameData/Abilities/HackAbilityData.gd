extends PlayerTargetedAbilityData
class_name HackAbilityData

var hack_duration = null
var forge_duration = null

func _init(cooldown, hack_duration, forge_duration).("Hack", cooldown):
		self.hack_duration = hack_duration
		self.forge_duration = forge_duration

func use(target: PlayerData):
	if not can_use(target):
		push_error("Illegal target!")
		return
	last_target = target
	start_cooldown()
	
	if target.has_effect("Protected"):
		return "protected"
	
	if target.has_effect("Forged"):
		target.get_effect("Forged").end += forge_duration
	else:
		target.effects.append(ForgedEffectData.new(forge_duration))
	
	for ability in target.abilities:
		if not ability.is_on_cooldown():
			ability.start_cd = Time.get_unix_time_from_system()
			ability.end_cd = ability.start_cd + hack_duration
		else:
			ability.end_cd += hack_duration
	
	return "yes"
