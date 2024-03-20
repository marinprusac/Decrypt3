extends Node

signal ability_used(player_name, target_name, ability_name)
signal crack_used(player_name, terminal_name, port_index, password)
signal backdoor_used(player_name, target_name, team_color)

signal requested_packet_sending(player_name, packet)

signal player_codes_submitted(client_codes)

func _on_receive_packet(player_name, packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	if packet_type == "ability_used":
		emit_signal("ability_used", player_name, packet_content["target"], packet_content["ability"])
	elif packet_type == "crack_used":
		emit_signal("crack_used", player_name, packet_content["terminal"], packet_content["port"], packet_content["password"])
	elif packet_type == "backdoor_used":
		emit_signal("backdoor_used", player_name, packet_content["target"], packet_content["color"])

func _send_packet_to_client(player, packet):
	emit_signal("requested_packet_sending", packet)

func submit_player_codes(settings: Settings):
	emit_signal("player_codes_submitted", settings.player_codes)
	
func send_welcome_packet(player_name: String, role: String,
						messages: Array, abilities: Dictionary,
						effects: Dictionary, players: Dictionary,
						terminals: Dictionary):
	var packet = {
		"packet_type": "welcome",
		"packet_content": {
			"you": {
				"name": player_name,
				"role": role,
				"messages": messages,
				"abilities": abilities,
				"effects": effects
			},
			"players": players,
			"terminals": terminals
		}
	}
	_send_packet_to_client(player_name, packet)

func send_start_packet(player_name, abilities, effects):
	var packet = {
		"packet_type": "started",
		"packet_content": {
			"abilities": abilities,
			"effects": effects
		}
	}
	_send_packet_to_client(player_name, packet)

func send_pause_packet(player_name):
	var packet = {
		"packet_type": "paused",
		"packet_content": {}
	}
	_send_packet_to_client(player_name, packet)

func send_end_packet(player_name, no_winner, victory):
	var packet = {
		"packet_type": "ended",
		"packet_content": {
			"no_winner": no_winner,
			"victory": victory
		}
	}
	_send_packet_to_client(player_name, packet)

func send_abilities_refresh_packet(player_name, abilities):
	var packet = {
		"packet_type": "abilities_refresh",
		"packet_content": abilities
	}
	_send_packet_to_client(player_name, packet)

func send_terminals_refresh_packet(player_name, terminals):
	var packet = {
		"packet_type": "terminals_refresh",
		"packet_content": terminals
	}
	_send_packet_to_client(player_name, packet)

func send_effects_refresh_packet(player_name, effects):
	var packet = {
		"packet_type": "effects_refresh",
		"packet_content": effects
	}
	_send_packet_to_client(player_name, packet)

func send_players_refresh_packet(player_name, players):
	var packet = {
		"packet_type": "players_refresh",
		"packet_content": players
	}
	_send_packet_to_client(player_name, packet)

func send_new_message(player_name, title, content, icon):
	var packet = {
		"packet_type": "new_message",
		"packet_content": {
			"title": title,
			"content": content,
			"icon": icon
		}
	}
	_send_packet_to_client(player_name, packet)
