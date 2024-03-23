extends Node

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal disconnected()

signal client_codes_sent(codes)
signal packet_sent(player_name, packet)
signal packet_received(player_name, packet)

export var url = ""
export var port = 0


func try_connect():
	emit_signal("trying_to_connect")

func force_disconnect():
	pass

func _on_connect():
	emit_signal("connected")

func _on_receive(player_name, packet):
	emit_signal("packet_received", player_name, packet)

func _on_disconnect():
	emit_signal("disconnected")

func send_client_codes(client_codes: Dictionary):
	emit_signal("client_codes_sent", client_codes)

func send(player_name, packet):
	emit_signal("packet_sent", player_name, packet)

