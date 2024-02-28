extends Node

signal welcome(packet_content)

signal ability_update(packet_content)

signal port_feedback(packet_content)

signal solved_termial(packet_content)

signal sabotaged_terminal(packet_content)

signal new_message(packet_content)

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_content"]
	
	var packet_types = ["welcome", "ability_update", "port_feedback",
	"solved_terminal", "sabotaged_terminal", "new_message"]
	
	for type in packet_types:
		if type == packet_type:
			emit_signal(type, packet_content)
