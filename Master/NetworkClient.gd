extends Node

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal server_disconnected()

export var url = ""
export var port = 0

var _last_password = ""


func try_connect(password):
	emit_signal("trying_to_connect", password)

func disconnect_from_server():
	pass

func _on_connect():
	emit_signal("connected")

func _on_receive():
	pass

func _on_disconnect():
	emit_signal("server_disconnected")
	try_connect(_last_password)

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		_on_connect()
	if Input.is_action_just_pressed("ui_down"):
		_on_disconnect()
	if Input.is_action_just_pressed("ui_left"):
		emit_signal("failed_to_connect")
