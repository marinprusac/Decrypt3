extends Control

signal exited_info()


func initialize(welcome_packet):
	var player_role = welcome_packet["you"]["role"]
	var text = "Your role is " + player_role + "."
	$"TabContainer/Roles/TabContainer/Your Role/Label".text = text

func enter():
	visible = true

func _on_exit():
	visible = false
	emit_signal("exited_info")
