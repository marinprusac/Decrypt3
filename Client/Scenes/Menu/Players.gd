extends HFlowContainer

signal player_chosen(target_name)

onready var player_button = preload("res://Client/Scenes/Menu/PlayerButton.tscn")


var activity_mode = "none"
var data: KnownData

func initialize(data: KnownData):
	self.data = data
	var players = data.players
	for player in players.keys():
		var player_packet = players[player]
		var pbutton = player_button.instance()
		pbutton.name = player
		pbutton.text = player
		pbutton.connect("pressed", self, "_on_button_press", [player])
		if player == data.name:
			pbutton.modulate = Color.turquoise
		elif player_packet["ally"]:
			pbutton.modulate = Color.lime
		add_child(pbutton)
	refresh()


func game_state_change(new_state):
	var states := data.GameState
	activity_mode = "none"
	_refresh_activity()

func refresh():
	if "Backdoor" in data.abilities.keys():
		var backdoored_players = data.abilities["Backdoor"]["backdoored_players"]
		for pbutton in get_children():
			if pbutton.name in backdoored_players:
				pbutton.modulate = Color.purple
	_refresh_activity()


func _on_selected_ability(ability_name):
	activity_mode = ability_name
	_refresh_activity()

func _on_selected_wrong_ability(ability):
	activity_mode = "none"
	_refresh_activity()

func _on_deselected_ability():
	activity_mode = "none"
	_refresh_activity()

func _refresh_activity():
	for pbutton in get_children():
		if activity_mode == "all":
			pbutton.disabled = false
		elif activity_mode == "none":
			pbutton.disabled = true
		elif activity_mode in data.abilities.keys():
			var abilities = data.abilities
			pbutton.disabled = not pbutton.name in abilities[activity_mode]["usable_on"]

func _on_button_press(player_name):
	emit_signal("player_chosen", player_name)


