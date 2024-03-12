extends Control


signal ability_toggled(pressed, ability_name)

var abilities_data: Dictionary = {}

var selected_ability = "none"

func refresh(abilities_packet: Dictionary):
	abilities_data = abilities_packet
	

func _on_button_toggled(pressed: bool):
	for ability in get_children():
		var button = ability
		if button.pressed:
			emit_signal("ability_toggled", true, button.name)
			selected_ability = button.name
	if not pressed:
		emit_signal("ability_toggled", false, null)
		selected_ability = "none"
			

func deselect():
	for ability in get_children():
		var button = ability
		if button.pressed:
			button.pressed = false
			emit_signal("ability_toggled", false, button.name)
	selected_ability = "none"


func _process(delta):
	var time_now = Time.get_unix_time_from_system()
	
	for ability in get_children():
		var ability_data = abilities_data[ability.name]
		var start_cd = ability_data["start_cooldown"]
		var end_cd = ability_data["end_cooldown"]
		
		
		
		var on_cooldown = end_cd != null and end_cd > time_now
		
		var usable = ability_data["usable"]
		var ready = usable and not on_cooldown
		
		var readyness = 0.0
		
		if usable:
			if not on_cooldown:
				readyness = 1
			else:
				readyness = float(time_now - start_cd) / float(end_cd - start_cd)
		
		var selected = selected_ability == ability.name
		var other_selected =  selected_ability != "none" and not selected
		
		ability.disabled = other_selected or not ready
		
		ability.material.set("shader_param/readyness", readyness)
		ability.material.set("shader_param/selected", selected)
		ability.material.set("shader_param/other_selected", other_selected)
		
