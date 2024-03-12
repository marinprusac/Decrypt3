extends Control

signal connecting_canceled()

func _on_trying_to_connect(_password):
	visible = true

func _on_stop_connecting():
	visible = false

func _on_cancel():
	_on_stop_connecting()
	emit_signal("connecting_canceled")


