extends TextureRect

var safe_color = Vector3(.25,.75,.25)
var trouble_color = Vector3(.75,.25,.25)

var rotation = 0.0
var chance = 0.5
var interpolating_chance = 0.5

func _ready():
	material.set("shader_param/color", safe_color)

func start():
	pass

func end(victory):
	pass

func set_chance(win_chance):
	chance = win_chance

func _process(delta):
	
	if Input.is_action_just_pressed("ui_up"):
		chance += 0.1
	elif Input.is_action_just_pressed("ui_down"):
		chance -= 0.1
	else:
		chance -= delta/10000.0
		
	var factor = 0.2
	print(round(interpolating_chance*1000)/1000, " ", round(chance*1000)/1000)
	interpolating_chance = lerp(interpolating_chance, chance, 1-pow(1-factor,delta))
	
	rotation = -interpolating_chance * 1000
	
	var chance_color = lerp(trouble_color, safe_color, interpolating_chance)
	var delta_color = safe_color if chance-interpolating_chance > 0 else trouble_color
	
	var color = lerp(chance_color, delta_color, abs(chance-interpolating_chance)*10)
	
	
	material.set("shader_param/rotation", rotation)
	material.set("shader_param/color", color)
