extends Node


signal welcome(known_data)
signal started()
signal pause_set(pause, time_elapse)
signal ended(no_winner, whitehat_victory)
signal refresh()
signal new_message(message_data)

signal packet_sent(packet)

var data: KnownData = null

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_content"]
	
	if packet_type == "welcome":
		data = KnownData.new(packet_content)
		emit_signal("welcome", data)
		
	elif packet_type == "started":
		data.game_state = data.GameState.RUNNING
		emit_signal("started")
		
	elif packet_type == "paused":
		data.game_state = data.GameState.PAUSED if packet_content["paused"] else data.GameState.RUNNING
		emit_signal("pause_set", packet_content["paused"], packet_content["time_elapsed"])
		
	elif packet_type == "ended":
		data.game_state = data.GameState.ENDED
		emit_signal("ended", packet_content["no_winner"], packet_content["victory"])
		
	elif packet_type == "abilities_refresh":
		data.abilities = packet_content
		emit_signal("refresh")
		
	elif packet_type == "terminals_refresh":
		data.terminals = packet_content
		emit_signal("refresh")
		
	elif packet_type == "new_message":
		data.messages.append(packet_content)
		emit_signal("new_message", packet_content)
	else:
		print("Unknown packet '" + packet_type +".'")

func _send_packet(packet):
	emit_signal("packet_sent", packet)

func _on_send_login_packet(password):
	var packet = {
		"packet_type": "login",
		"packet_content": password
	}
	_send_packet(packet)


func _on_send_hack_packet(target_name):
	var packet = {
		"packet_type": "hack_used",
		"packet_content": {
			"target": target_name
		}
	}
	_send_packet(packet)

func _on_send_protect_packet(target_name):
	var packet = {
		"packet_type": "protect_used",
		"packet_content": {
			"target": target_name
		}
	}
	_send_packet(packet)

func _on_send_scan_packet(target_name, team_color):
	var packet = {
		"packet_type": "scan_used",
		"packet_content": {
			"target": target_name,
			"color": team_color
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

func _on_send_sabotage_packet(terminal_name, port_index, password):
	var packet = {
		"packet_type": "sabotage_used",
		"packet_content": {
			"terminal": terminal_name,
			"port": port_index,
			"password": password
		}
	}
	_send_packet(packet)

func _on_send_backdoor_packet(target_name, team_color):
	var packet = {
		"packet_type": "backdoor_used",
		"packet_content": {
			"color": team_color,
			"target": target_name
		}
	}
	_send_packet(packet)


