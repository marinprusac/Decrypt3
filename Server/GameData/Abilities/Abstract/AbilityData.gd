extends Resource
class_name AbilityData

var name: String
var cooldown: float
var start_cd = null
var end_cd = null

func _init(name, cooldown):
	self.name = name
	self.cooldown = cooldown

func is_on_cooldown():
	var now = Time.get_unix_time_from_system()
	if end_cd == null:
		return false
	return end_cd > now

func start_cooldown():
	start_cd = Time.get_unix_time_from_system()
	end_cd = start_cd + cooldown

func to_dict(player, targets):
	return {
		"start_cooldown": start_cd,
		"end_cooldown": end_cd
	}
