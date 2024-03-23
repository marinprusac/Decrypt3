extends Node

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal disconnected()

signal sent(packet)
signal packet_received(packet)

export var url = ""
export var port = 0

var _last_password = ""


func try_connect(password):
	emit_signal("trying_to_connect")

func force_disconnect():
	pass

func _on_connect():
	emit_signal("connected")

func _on_receive(packet):
	emit_signal("packet_received", packet)

func _on_disconnect():
	emit_signal("disconnected")

func send(packet):
	emit_signal("sent", packet)

