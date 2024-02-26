extends Control

signal connecting_canceled()

func _on_trying_to_connect(_password):
	visible = true

func _on_connected():
	visible = false

func _on_connecting_failed():
	visible = false

func stop_connecting():
	emit_signal("connecting_canceled")
	visible = false


