extends GridContainer

signal pressed_terminal_button(tname, crack_mode)

onready var terminal_button_preload = preload("res://Client/Scenes/Menu/TerminalButton.tscn")
var data: KnownData

enum {
	NONE,
	UNSOLVED,
	CRACKABLE,
	ALL
}
var activity_mode = UNSOLVED

func initialize(data: KnownData):
	self.data = data
	for tname in data.terminals.keys():
		var terminal_packet = data.terminals[tname]
		
		var tbutton = terminal_button_preload.instance()
		
		tbutton.name = tname
		tbutton.text = tname
		tbutton.connect("pressed", self, "_on_button_press", [tname])
		
		if terminal_packet["solved"]:
			tbutton.modulate = Color(0, 1, 0)
			
		add_child(tbutton)
	_refresh_activity()


func game_state_change(new_state):
	var states := data.GameState
	if new_state == states.RUNNING:
		activity_mode = UNSOLVED
	if new_state == states.PAUSED:
		activity_mode = UNSOLVED
	if new_state == states.ENDED:
		activity_mode = NONE
	_refresh_activity()


func refresh():
	for tname in data.terminals.keys():
		var terminal_packet = data.terminals[tname]
		var tbutton = get_node(tname)
		if terminal_packet["solved"]:
			tbutton.modulate = Color(0, 1, 0)
	_refresh_activity()


func _on_selected_ability(ability_name):
	activity_mode = CRACKABLE
	_refresh_activity()

func _on_selected_wrong_ability(ability):
	activity_mode = NONE
	_refresh_activity()

func _on_deselected_ability():
	activity_mode = UNSOLVED
	_refresh_activity()

func _refresh_activity():
	for terminal_button in get_children():
		var terminal_data = data.terminals[terminal_button.name]
		if activity_mode == NONE:
			terminal_button.disabled = true
		elif activity_mode == CRACKABLE:
			var ability = data.abilities["Crack"] if "Crack" in data.abilities.keys() else data.abilities["Sabotage"]
			terminal_button.disabled = terminal_data["solved"] or not terminal_button.name in ability["usable_on"]
		elif activity_mode == UNSOLVED:
			terminal_button.disabled = terminal_data["solved"]
		elif activity_mode == ALL:
			terminal_button.disabled = false

func _on_button_press(tname):
	emit_signal("pressed_terminal_button", tname, activity_mode==CRACKABLE)


