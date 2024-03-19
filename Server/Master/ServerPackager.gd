extends Node

signal login(player_name, packet_content)

signal ability_used(player_name, packet_content)
signal crack_used(player_name, packet_content)
signal backdoor_used(player_name, packet_content)

signal packet_sent_to_player(player_name, packet)

func _on_receive_packet(player_name, packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	var packet_types = [ "login", "ability_used", "crack_used", "backdoor_used"]
	
	for type in packet_types:
		if type == packet_type:
			emit_signal(type, player_name, packet_content)


func _send_packet_to_client(player, packet):
	emit_signal("packet_sent", packet)


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




