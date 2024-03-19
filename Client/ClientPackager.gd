extends Node

signal welcome(packet_content)

signal started(packet_content)
signal paused(packet_content)
signal ended(packet_content)

signal abilities_refresh(packet_content)
signal terminals_refresh(packet_content)
signal effects_refresh(packet_content)
signal players_refresh(packet_content)
signal new_message(packet_content)


signal packet_sent(packet)

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	var packet_types = ["started", "paused", "ended", "welcome",
	"abilities_refresh", "terminals_refresh", "effects_refresh", "players_refresh", "new_message"]
	
	for type in packet_types:
		if type == packet_type:
			emit_signal(type, packet_content)

func _send_packet(packet):
	emit_signal("packet_sent", packet)

func _on_send_login_packet(password):
	var packet = {
		"packet_type": "login",
		"packet_content": password
	}
	_send_packet(packet)

func _on_send_ability_packet(ability_name, target_name):
	var packet = {
		"packet_type": "ability_used",
		"packet_content": {
			"ability": ability_name,
			"target": target_name
		}
	}
	_send_packet(packet)

func _on_send_crack_packet(terminal_name, port_index, password):
	var packet = {
		"packet_type": "crack_used",
		"packet_content": {
			"terminal": terminal_name,
			"port": port_index,
			"password": password
		}
	}
	_send_packet(packet)

func _on_send_backdoor_packet(terminal_name, team_color, target_name):
	var packet = {
		"packet_type": "backdoor_used",
		"packet_content": {
			"team": team_color,
			"target": target_name
		}
	}
	_send_packet(packet)
