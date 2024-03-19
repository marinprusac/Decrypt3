extends Node

signal welcome(packet_content)

signal ability_refresh(packet_content)

signal terminal_refresh(packet_content)

signal player_refresh(packet_content)

signal new_message(packet_content)

signal packet_sent(packet)

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	var packet_types = ["welcome", "ability_refresh", "terminal_refresh",
	"player_refresh", "new_message"]
	
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
		"packet_type": "ability",
		"packet_content": {
			"ability": ability_name,
			"target": target_name
		}
	}
	_send_packet(packet)

func _on_send_crack_packet(terminal_name, port_index, password):
	var packet = {
		"packet_type": "crack",
		"packet_content": {
			"terminal": terminal_name,
			"port": port_index,
			"password": password
		}
	}
	_send_packet(packet)

