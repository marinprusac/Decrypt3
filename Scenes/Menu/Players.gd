extends HFlowContainer

signal used_ability_on_player(ability_name, target_name)

onready var player_button = preload("res://Scenes/Menu/PlayerButton.tscn")
var players_data: Dictionary = {}


var activity_mode = "none"

func initialize(players, player_name):
	players_data = players
	for player in players.keys():
		var player_packet = players[player]
		var pbutton = player_button.instance()
		pbutton.name = player
		pbutton.text = player
		pbutton.connect("pressed", self, "_on_button_press", [player])
		if player == player_name:
			pbutton.modulate = Color.turquoise
		elif player_packet["ally"]:
			pbutton.modulate = Color.lime
		elif "Backdoored" in player_packet["effects"]:
			pbutton.modulate = Color.purple
		add_child(pbutton)
	_refresh_activity()

func clear():
	for child in get_children():
		child.queue_free()
	players_data.clear()

func refresh(players):
	players_data = players
	for pbutton in get_children():
		var player_packet = players[pbutton.name]
		if "Backdoored" in player_packet["effects"]:
			pbutton.modulate = Color.purple
	_refresh_activity()


func _on_ability_toggled(pressed, ability_name):
	if not pressed:
		activity_mode = "none"
	else:
		activity_mode = ability_name
	_refresh_activity()


func _refresh_activity():
	for pbutton in get_children():
		if activity_mode == "all":
			pbutton.disabled = false
		elif activity_mode == "none":
			pbutton.disabled = true
		else:
			pbutton.disabled = not activity_mode in players_data[pbutton.name]["usable_abilities"]

func _on_button_press(player_name):
	emit_signal("used_ability_on_player", activity_mode, player_name)
