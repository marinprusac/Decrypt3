extends Control

signal opened_terminal(index)
signal opened_info()
signal opened_messages()

onready var terminal_button = preload("res://Scenes/Menu/TerminalButton.tscn")
onready var player_button = preload("res://Scenes/Menu/PlayerButton.tscn")


func initialize(welcome_packet_content):
	pass


func open_terminal(index):
	visible = false
	emit_signal("opened_terminal", index)

func open_info():
	visible = false
	emit_signal("opened_info")

func open_messages():
	visible = false
	emit_signal("opened_messages")

