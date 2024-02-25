extends Node2D

var terminal_preload = preload("res://Terminal/Terminal.tscn")
var terminal

func quit_terminal():
	terminal.queue_free()


func _ready():
	terminal = terminal_preload.instance()
	terminal.terminal_name = "B"
	terminal.guessing = false
	terminal.connect("quitted", self, "quit_terminal")
	add_child(terminal)



