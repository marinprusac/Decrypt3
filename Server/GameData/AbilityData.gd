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
