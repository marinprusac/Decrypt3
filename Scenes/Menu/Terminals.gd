extends GridContainer

signal pressed_terminal_button(tname, crack_mode)

onready var terminal_button_preload = preload("res://Scenes/Menu/TerminalButton.tscn")
var terminals_data: Dictionary = {}

enum {
	NONE,
	UNSOLVED,
	CRACKABLE,
	ALL
}

var activity_mode = UNSOLVED

func initialize(terminals):
	terminals_data = terminals
	for tname in terminals.keys():
		var terminal_packet = terminals_data[tname]
		
		var tbutton = terminal_button_preload.instance()
		
		tbutton.name = tname
		tbutton.text = tname
		tbutton.connect("pressed", self, "_on_button_press", [tname])
		
		if terminal_packet["solved"]:
			tbutton.modulate = Color(0, 1, 0)
			
		add_child(tbutton)
	_refresh_activity()

func clear():
	terminals_data.clear()
	for child in get_children():
		child.queue_free()

func refresh(terminals):
	terminals_data = terminals
	for tname in terminals.keys():
		var terminal_packet = terminals[tname]
		var tbutton = get_node(terminal_packet["name"])
		if terminal_packet["solved"]:
			tbutton.modulate = Color(0, 1, 0)
	_refresh_activity()


func _on_ability_toggled(pressed, ability_name):
	if not pressed:
		activity_mode = UNSOLVED
	elif ability_name == "Crack":
		activity_mode = CRACKABLE
	else:
		activity_mode = NONE
	_refresh_activity()

func _refresh_activity():
	for terminal_button in get_children():
		var terminal_data = terminals_data[terminal_button.name]
		if activity_mode == NONE:
			terminal_button.disabled = true
		elif activity_mode == CRACKABLE:
			terminal_button.disabled = not terminal_data["crackable"]
		elif activity_mode == UNSOLVED:
			terminal_button.disabled = terminal_data["solved"]
		elif activity_mode == ALL:
			terminal_button.disabled = false

func _on_button_press(tname):
	emit_signal("pressed_terminal_button", tname, activity_mode==CRACKABLE)
