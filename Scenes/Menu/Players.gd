extends HFlowContainer

func refresh_last_targets(abilities_packet):
	
	for player in get_children():
		player.last_used_abilities = []
		player.backdoored = false
	
	for ability_name in abilities_packet.keys():
		var ability = abilities_packet[ability_name]
		if ability["last_target"] != null:
			var player: PlayerButton = get_node(ability["last_target"])
			if player:
				player.last_used_abilities.append(ability_name)
	
	var backdoored_players = abilities_packet["Backdoor"]["players"]
	for player_name in backdoored_players:
		var player: PlayerButton = get_node(player_name)
		player.modulate = Color(1, 0.5, 1)
		player.backdoored = true


func _on_ability_toggled(pressed, ability_name):
	for player in get_children():
		var p: PlayerButton = player
		if not pressed or p.is_you:
			p.disabled = true
		elif ability_name == "Crack":
			p.disabled = true
		elif ability_name in p.last_used_abilities:
			p.disabled = true
		elif ability_name == "Backdoor" and p.backdoored:
			p.disabled = true
		else:
			p.disabled = false
		

