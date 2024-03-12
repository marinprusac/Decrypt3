extends Control
class_name Login

signal password_submitted(password)

func _ready():
	enter()

func enter():
	visible = true

func submit_password():
	visible = false
	emit_signal("password_submitted", $TextDisplay.get_content())
