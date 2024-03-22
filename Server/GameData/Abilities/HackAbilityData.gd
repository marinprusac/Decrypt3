extends PlayerTargetedAbilityData
class_name HackAbilityData

var hack_duration = null
var forge_duration = null

func _init(cooldown, hack_duration, forge_duration).("Hack", cooldown):
		self.hack_duration = hack_duration
		self.forge_duration = forge_duration
