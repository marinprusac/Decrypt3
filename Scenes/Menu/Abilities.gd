extends Control


signal ability_toggled(pressed, ability_name)

func refresh_ability_cooldowns(abilities_packet: Dictionary):
	for ability_name in abilities_packet.keys():
		var ability_packet = abilities_packet[ability_name]
		var ability: AbilityButton = get_node(ability_name)
		ability.update_cooldowns(ability_packet["start_cooldown"], ability_packet["end_cooldown"])
		ability.usable = ability_packet["usable"]


func _on_button_toggled(pressed: bool):
	for ability in get_children():
		var button: AbilityButton = ability
		button.selected = button.pressed
		if not button.pressed:
			button.other_selected = pressed
		else:
			emit_signal("ability_toggled", true, button.name)
	if not pressed:
		emit_signal("ability_toggled", false, null)
			

func deselect():
	for ability in get_children():
		var button: AbilityButton = ability
		if button.pressed:
			button.pressed = false
			emit_signal("ability_toggled", false, button.name)
