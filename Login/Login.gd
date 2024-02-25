extends Node2D

signal password_submitted(password)

func on_submit_password():
	emit_signal("password_submitted", $TextDisplay.get_content())

