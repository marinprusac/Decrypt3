extends PlayerTargetedAbilityData
class_name BackdoorAbilityData

var effect_duration = null

func _init(cooldown, effect_duration).("Backdoor", cooldown):
	self.effect_duration = effect_duration

func is_valid_target(player, target):
	return target != player and target != last_target and not target.has_effect("Backdoored")


func to_dict(player, players):
	var backdoored = []
	var usable_on = []
	
	for target in players:
		if is_valid_target(player, target):
			usable_on.append(target.name)
		if target.has_effect("Backdoored"):
			backdoored.append(target.name)
	
	return {
		"start_cooldown": start_cd,
		"end_cooldown": end_cd,
		"usable_on": usable_on,
		"backdoored_players": backdoored
	}
