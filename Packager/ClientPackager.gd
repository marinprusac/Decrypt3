extends Node

signal welcome(packet_content)

signal ability_refresh(packet_content)

signal terminal_refresh(packet_content)

signal player_refresh(packet_content)

signal new_message(packet_content)

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	var packet_types = ["welcome", "ability_refresh", "terminal_refresh",
	"player_refresh", "new_message"]
	
	for type in packet_types:
		if type == packet_type:
			emit_signal(type, packet_content)
