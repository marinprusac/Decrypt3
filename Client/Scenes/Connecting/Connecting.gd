extends Control

signal connecting_canceled()

func _on_trying_to_connect(password):
	visible = true

func _on_stop_connecting(data):
	visible = false

func _on_cancel():
	_on_stop_connecting(null)
	emit_signal("connecting_canceled")
