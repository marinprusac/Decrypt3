extends Resource
class_name AbilityData

var name: String
var last_target: String
var cooldown: float
var start_cd
var end_cd

func _init(name, cooldown):
	self.name = name
	self.cooldown = cooldown
	start_cd = null
	end_cd = null

func is_on_cooldown():
	var now = Time.get_unix_time_from_system()
	if end_cd == null:
		return false
	return end_cd > now

func use(last_target):
	start_cd = Time.get_unix_time_from_system()
	end_cd = start_cd + cooldown
	self.last_target = last_target
