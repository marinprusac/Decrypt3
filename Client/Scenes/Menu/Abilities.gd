extends Control

signal selected_player_ability(ability)
signal selected_terminal_ability(ability)
signal deselected()

signal used_hack(target)
signal used_protect(target)
signal used_scan(target, color)
signal used_crack(terminal, port, pasword)
signal used_sabotage(terminal, port, pasword)
signal used_backdoor(target, color)

var data: KnownData

var selected_ability = "none"

var color_ability = null
var color_selecting = null

func initialize(data: KnownData):
	self.data = data
	get_child(0).get_child(0).name = "Crack" if "Crack" in data.abilities else "Sabotage"

func refresh():
	pass

func _on_button_toggled(pressed: bool):
	if not pressed:
		deselect()
	
	for ability in get_children()[0].get_children():
		var button = ability as Button
		if button.pressed:
			selected_ability = button.name
			if button.name in ["Crack", "Sabotage"]:
				emit_signal("selected_terminal_ability", button.name)
			elif button.name in ["Scan", "Backdoor"]:
				_start_choosing_color_buttons()
			elif button.name in ["Hack", "Protect"]:
				emit_signal("selected_player_ability", button.name)
			
func _on_chosen_player(target_name):
	if selected_ability == "Hack":
		emit_signal("used_hack", target_name)
	if selected_ability == "Protect":
		emit_signal("used_protect", target_name)
	if selected_ability == "Scan":
		emit_signal("used_scan", target_name, color_selecting)
	if selected_ability == "Backdoor":
		emit_signal("used_backdoor", target_name, color_selecting)
	deselect()

func _on_chosen_terminal(terminal_name, port_name, password):
	if selected_ability == "Crack":
		emit_signal("used_crack", terminal_name, port_name, password)
	if selected_ability == "Sabotage":
		emit_signal("used_sabotage", terminal_name, port_name, password)
	deselect()

func deselect():
	for ability in get_children()[0].get_children():
		var button = ability
		if button.pressed:
			button.pressed = false
	selected_ability = "none"
	color_selecting = null
	$ColorButtons.visible = false
	emit_signal("deselected")

func _start_choosing_color_buttons():
	$ColorButtons.visible = true

func _on_chosen_red_button():
	color_selecting = "red"
	_on_color_button_chosen()

func _on_chosen_blue_button():
	color_selecting = "blue"
	_on_color_button_chosen()

func _on_chosen_yellow_button():
	color_selecting = "yellow"
	_on_color_button_chosen()

func _on_color_button_chosen():
	$ColorButtons.visible = false
	emit_signal("selected_player_ability", selected_ability)
	

func _process(delta):
	if data == null or data.game_state != data.GameState.RUNNING:
		return
	
	var time_now = Time.get_unix_time_from_system()
	
	for ability in get_children()[0].get_children():
		if not ability.name in data.abilities.keys():
			ability.material.set("shader_param/readyness", (int(Time.get_unix_time_from_system())%90)/100.0)
			ability.disabled = true
			continue
		
		var ability_data = data.abilities[ability.name]
		var start_cd = ability_data["start_cooldown"]
		var end_cd = ability_data["end_cooldown"]
		
		var on_cooldown = end_cd != null and end_cd > time_now
		var ready = not on_cooldown
		
		var readyness = 0.0
		
		if ready:
			readyness = 1
		else:
			readyness = float(time_now - start_cd) / float(end_cd - start_cd)
		
		var selected = selected_ability == ability.name
		var other_selected =  selected_ability != "none" and not selected
		
		ability.disabled = other_selected or not ready
		
		ability.material.set("shader_param/readyness", readyness)
		ability.material.set("shader_param/selected", selected)
		ability.material.set("shader_param/other_selected", other_selected)
		
