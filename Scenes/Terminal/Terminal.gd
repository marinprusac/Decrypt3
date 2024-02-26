extends Control

signal password_submitted(password)
signal quitted()

export var terminal_name: String = "?"
export var guessed_passwords: Dictionary
export var guessing = false

var guessing_index = -1

func _ready():
	$Title/Label.text = "Terminal " + terminal_name
	$Keyboard.visible = false

	var password_nodes = $Passwords.get_children()
	
	for i in range(len(password_nodes)):
		var pass_node: Node2D = password_nodes[i]
		var label = pass_node.get_node("Label")
		var display = pass_node.get_node("TextDisplay")
		var button: TouchScreenButton = pass_node.get_node("Key")
		
		label.text = terminal_name+str(i+1)
		button.connect("pressed", self, "on_choose_guess", [i])
		
		if guessing:
			if i in guessed_passwords.keys():
				display.write(guessed_passwords[i])
				display.modulate = Color(0, 0.5, 0)
				button.visible = false
			else:
				display.visible = false
		else:
			if i in guessed_passwords.keys():
				display.write(guessed_passwords[i])
				display.modulate = Color(0, 0.5, 0)
			else:
				display.write("??")
				display.modulate = Color(0.25, 0.25, 0.25)
			button.visible = false


func on_choose_guess(index: int):
	var pass_nodes = $Passwords.get_children()
	if not guessing or index in guessed_passwords.keys() or guessing_index != -1 or index >= len(pass_nodes):
		return
		
	guessing_index = index
	$Keyboard.visible = true
	
	for i in range(len(pass_nodes)):
		var pass_node = pass_nodes[i]
		var button: TouchScreenButton = pass_node.get_node("Key")
		button.visible = false
		if i == guessing_index:
			var display = pass_node.get_node("TextDisplay")
			display.visible = true
			$Keyboard.connect("digit_pressed", display, "append")
			$Keyboard.connect("digit_erased", display, "erase")
			$Keyboard.connect("enter", self, "on_submit_password")


func on_submit_password():
	if guessing_index == -1:
		return
	var pass_node = $Passwords.get_child(guessing_index)
	var display = pass_node.get_node("TextDisplay")
	var password = display.get_content()
	
	if len(password) != display.length:
		return
		
	emit_signal("password_submitted")


func on_quit():
	emit_signal("quitted")
