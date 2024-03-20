extends Node

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal disconnected()
signal packet_received(player_name, packet)

export var url = ""
export var port = 0


func try_connect():
	emit_signal("trying_to_connect")

func force_disconnect():
	pass

func _on_connect():
	emit_signal("connected")
	
	var packet = {
		"packet_type": "welcome",
		"packet_data" : {
			"you": {
				"name": "Marin",
				"role": "Blackhat",
				"effects": {},
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
				}],
				"abilities": {
					"Hack": {
						"start_cooldown": 13000,
						"end_cooldown": 17000
					},
					"Protect": {
						"start_cooldown": Time.get_unix_time_from_system() - 180,
						"end_cooldown": Time.get_unix_time_from_system() + 60
					},
					"Scan": {
						"start_cooldown": Time.get_unix_time_from_system() - 12*60/2,
						"end_cooldown": Time.get_unix_time_from_system() + 12*60/2
					},
					"Crack": {
						"start_cooldown": Time.get_unix_time_from_system(),
						"end_cooldown": Time.get_unix_time_from_system() + 5
					},
					"Backdoor": {
						"start_cooldown": null,
						"end_cooldown": null,
					}
			},
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
			}
		}
	}
	_on_receive("Marin", packet)

func _on_receive(player_name, packet):
	emit_signal("packet_received", player_name, packet)

func _on_disconnect():
	emit_signal("disconnected")
	try_connect()

func send_client_codes(client_codes: Dictionary):
	pass

func send(player_name, packet):
	pass
