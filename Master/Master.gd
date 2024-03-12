extends Node


func _ready():
	$Login.start()
	
func _on_connected():
	$Connecting.visible = false
	$Menu.visible = true

func _on_disconnected():
	$Connecting.visible = false
	$Menu.visible = false
	$Messages.visible = false
	$Info.visible = false
	$Login.start()
	


