extends Button
class_name AbilityButton

var usable = true
var selected = false
var other_selected = false

var _start_cooldown = null
var _end_cooldown = null

func _now():
	return Time.get_unix_time_from_system()

func is_on_cooldown():
	if _end_cooldown == null:
		return false
	return _now() < _end_cooldown

func is_ready():
	return usable and not other_selected and not is_on_cooldown()

func update_cooldowns(start_cooldown, end_cooldown):
	_start_cooldown = start_cooldown
	_end_cooldown = end_cooldown


func _process(delta):
	disabled = not is_ready()
	var readyness = 1.0
	if _end_cooldown and _start_cooldown:
		var interval = _end_cooldown - _start_cooldown
		if interval != 0:
			readyness = (_now()-_start_cooldown) / interval
	if not usable:
		readyness = 0
	
	material.set("shader_param/readyness", readyness)
	material.set("shader_param/selected", selected)
	material.set("shader_param/other_selected", other_selected)
