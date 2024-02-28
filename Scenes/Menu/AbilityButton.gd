extends Button


var _usable = true

var _now = 0
var _start_cooldown = 0
var _end_cooldown = 0


func set_usable(usable: bool):
	pass

func update_cooldowns(now, start_cooldown, end_cooldown):
	_now = now
	_start_cooldown = start_cooldown
	_end_cooldown = end_cooldown



func _on_other_selected():
	disabled = false




func _ready():
	pass

func _process(delta):
	_now += delta * 1000
