extends Control

signal exited_info()


func initialize(data: KnownData):
	var text = "Your role is " + data.role + "."
	$"TabContainer/Roles/TabContainer/Your Role/Label".text = text

func _on_disconnected():
	var text = "Your role is ?"
	$"TabContainer/Roles/TabContainer/Your Role/Label".text = text
	visible = false

func enter():
	visible = true

func _on_exit():
	visible = false
	emit_signal("exited_info")
