extends Control

signal opened_terminal(index)
signal opened_info()
signal opened_messages()

onready var terminal_button = preload("res://Scenes/Menu/TerminalButton.tscn")
onready var player_button = preload("res://Scenes/Menu/PlayerButton.tscn")


func _ready():
	var packet = {
		"packet_type": "welcome",
		"packet_data" : {
			"you": {
				"name": "Marin",
				"role": "Red Team Whitehat",
				"hacked": false,
				"backdoored": true,
			},
			"players": [
				"Marin",
				"Jelena",
				"Patrik",
				"Mauro",
				"Luka"
			],
			"abilities": {
				"Hack": {
					"usable": true,
					"last_target": null,
					"start_cooldown": 13000,
					"end_cooldown": 17000
				},
				"Protect": {
					"usable": true,
					"last_target": "Jelena",
					"start_cooldown": null,
					"end_cooldown": null
				},
				"Scan": {
					"usable": true,
					"last_target": null,
					"start_cooldown": null,
					"end_cooldown": null
				},
				"Crack": {
					"usable": true,
					"last_target": "A",
					"start_cooldown": null,
					"end_cooldown": null
				},
				"Backdoor": {
					"usable": false,
					"last_target": null,
					"start_cooldown": null,
					"end_cooldown": null,
					"players": []
				}
			},
			"terminals": [
				{
					"name": "A",
					"solved": false,
					"port_passwords": ["", "", "23"]
				},
				{
					"name": "B",
					"solved": true,
					"port_passwords": ["11", "", "00"]
				},
				{
					"name": "C",
					"solved": true,
					"port_passwords": ["11", "", "00"]
				}
			],
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
	for p in players:
		var new_p_button = player_button.instance()
		new_p_button.disabled = true
		new_p_button.name = p
		new_p_button.text = p
		if p == welcome_packet_content["you"]["name"]:
			new_p_button.is_you = true
		$Players.add_child(new_p_button)
	
	var terminals = welcome_packet_content["terminals"]
	for t in terminals:
		var new_t_button = terminal_button.instance()
		new_t_button.name = t["name"]
		new_t_button.text = t["name"]
		$CenterContainer/Terminals.add_child(new_t_button)

	
	

	
	var abilities = welcome_packet_content["abilities"]
	$CenterContainer/Terminals.refresh_solved_terminals(terminals)
	$CenterContainer/Terminals.set_last_used(abilities["Crack"]["last_target"])
	$Players.refresh_last_targets(abilities)
	$Abilities.refresh_ability_cooldowns(abilities)
	
	

		


func open_terminal(index):
	visible = false
	emit_signal("opened_terminal", index)

func open_info():
	visible = false
	emit_signal("opened_info")

func open_messages():
	visible = false
	emit_signal("opened_messages")

