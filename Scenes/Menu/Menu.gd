extends Control

signal opened_terminal(index)
signal opened_info()
signal opened_messages()


func _ready():
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
					"crackable": false,
					"port_passwords": ["11", "", "00"]
				},
				"C": {
					"solved": true,
					"crackable": false,
					"port_passwords": ["11", "", "00"]
				}
			},
			"messages": [
				{
					"type": "Hack Action",
					"title": "Hack: Jelena",
					"content": "You successfully hacked Jelena!"
				},
				{
					"type": "Terminal Decrypt",
					"title": "Terminal A Decrypted",
					"content": "Terminal A has been successfully decrypted."
				}
			]
		}
	}
	initialize(packet["packet_data"])


func initialize(welcome_packet_content: Dictionary):
	
	var players = welcome_packet_content["players"]
	var terminals = welcome_packet_content["terminals"]
	var player_name = welcome_packet_content["you"]["name"]
	var abilities = welcome_packet_content["abilities"]
	
	$Players.initialize(players, player_name)
	$CenterContainer/Terminals.initialize(terminals)
	$Abilities.refresh(abilities)


func open_terminal(index):
	visible = false
	emit_signal("opened_terminal", index)

func open_info():
	visible = false
	emit_signal("opened_info")

func open_messages():
	visible = false
	emit_signal("opened_messages")

