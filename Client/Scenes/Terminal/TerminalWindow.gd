extends Control

signal password_submitted(terminal_name, port_index, password)
signal quitted()

var terminal_port_preload = preload("res://Client/Scenes/Terminal/TerminalPort.tscn")

var data: KnownData

var terminal_name = "?"
var guessing_index = -1

func initialize(data: KnownData):
	self.data = data

func refresh():
	_on_quit()

func _on_open_terminal(terminal_name, crack_mode):
	clear()
	visible = true
	self.terminal_name = terminal_name
	var terminal_packet = data.terminals[terminal_name]
	var port_passwords = terminal_packet["port_passwords"]
	
	$Title.text = "Terminal " + terminal_name
	
	for i in range(len(port_passwords)):
		var password = port_passwords[i]
		var terminal_port = terminal_port_preload.instance()
		
		var text_display = terminal_port.get_node("TextDisplay")
		var port_button = terminal_port.get_node("Button")
		terminal_port.get_node("PortName").text = terminal_name + str(i+1)
		
		$CenterContainer/Ports.add_child(terminal_port)
		
		if password != "":
			text_display.write(password)
			text_display.modulate = Color.green
		
		port_button.visible = crack_mode and password == ""
		port_button.connect("pressed", self, "_on_choose_guess", [i])

func _on_choose_guess(index: int):
	$Keyboard.visible = true
	guessing_index = index
	
	for i in range($CenterContainer/Ports.get_child_count()):
		var terminal_port = $CenterContainer/Ports.get_child(i)
		if i == index:
			var display = terminal_port.get_node("TextDisplay")
			$Keyboard.connect("digit_pressed", display, "append")
			$Keyboard.connect("digit_erased", display, "erase")
			terminal_port.get_node("Button").visible = false
		else:
			terminal_port.visible = false


func _on_submit_password():
	if guessing_index == -1:
		return
	var pass_node = $CenterContainer/Ports.get_child(guessing_index)
	var display = pass_node.get_node("TextDisplay")
	var password = display.get_content()
	
	if len(password) != display.length:
		return
		
	emit_signal("password_submitted", terminal_name, guessing_index, password)
	_on_quit()
	guessing_index = -1

func _on_disconnected():
	visible = false
	clear()

func clear():
	for port in $CenterContainer/Ports.get_children():
		port.queue_free()
	terminal_name = "?"
	guessing_index = -1
	$Keyboard.visible = false
	$Title.text = "Terminal ?"

func _on_quit():
	visible = false
	guessing_index = -1
	emit_signal("quitted")
