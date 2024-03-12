extends Node

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal server_disconnected()
signal packet_received(packet)

export var url = ""
export var port = 0

var _last_password = ""


func try_connect(password):
	emit_signal("trying_to_connect", password)

func disconnect_from_server():
	pass

func _on_connect():
	emit_signal("connected")
	
	var packet = {
		"packet_type": "welcome",
		"packet_data" : {
			"you": {
				"name": "Marin",
				"role": "Blackhat",
				"effects": []
			},
			"players": {
				"Marin": {
					"usable_abilities": [],
					"effects": [],
					"ally": true
				},
				"Jelena": {
					"usable_abilities": [],
					"effects": [],
					"ally": true
				},
				"Patrik": {
					"usable_abilities": ["Hack"],
					"effects": [],
					"ally": false
				},
				"Mauro": {
					"usable_abilities": ["Scan"],
					"effects": ["Backdoored"],
					"ally": false
				},
				"Luka": {
					"usable_abilities": ["Protect"],
					"effects": [],
					"ally": false
				}
			},
			"abilities": {
				"Hack": {
					"usable": true,
					"start_cooldown": 13000,
					"end_cooldown": 17000
				},
				"Protect": {
					"usable": true,
					"start_cooldown": Time.get_unix_time_from_system() - 180,
					"end_cooldown": Time.get_unix_time_from_system() + 60
				},
				"Scan": {
					"usable": true,
					"start_cooldown": Time.get_unix_time_from_system() - 12*60/2,
					"end_cooldown": Time.get_unix_time_from_system() + 12*60/2
				},
				"Crack": {
					"usable": true,
					"start_cooldown": Time.get_unix_time_from_system(),
					"end_cooldown": Time.get_unix_time_from_system() + 5
				},
				"Backdoor": {
					"usable": false,
					"start_cooldown": null,
					"end_cooldown": null,
				}
			},
			"terminals": {
				"A": {
					"solved": false,
					"crackable": true,
					"port_passwords": ["", "", "23"]
				},
				"B": {
					"solved": false,
					"crackable": true,
					"port_passwords": ["11", ""]
				},
				"C": {
					"solved": true,
					"crackable": false,
					"port_passwords": ["11", "", "00"]
				},
				"D": {
					"solved": false,
					"crackable": true,
					"port_passwords": ["", "", ""]
				},
				"E": {
					"solved": true,
					"crackable": false,
					"port_passwords": ["11", "", "00"]
				}
			},
			"messages": [
				{
					"icon": "Hack",
					"title": "Hack: Jelena",
					"content": "You successfully hacked Jelena!"
				},
				{
					"icon": "Password",
					"title": "Terminal A Decrypted",
					"content": "Terminal A has been successfully decrypted."
				}
			]
		}
	}
	_on_receive(packet)

func _on_receive(packet):
	emit_signal("packet_received", packet)

func _on_disconnect():
	emit_signal("server_disconnected")
	try_connect(_last_password)

func _on_send(packet):
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		_on_connect()
	if Input.is_action_just_pressed("ui_down"):
		_on_disconnect()
	if Input.is_action_just_pressed("ui_left"):
		emit_signal("failed_to_connect")
