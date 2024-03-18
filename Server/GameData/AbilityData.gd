extends Resource
class_name AbilityData

var name
var cooldown
var last_target
var start_cd
var end_cd


func _init(name, cooldown):
	self.name = name
	self.cooldown = cooldown
