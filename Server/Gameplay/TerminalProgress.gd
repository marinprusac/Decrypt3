extends Control

var terminal_name = "?"
var max_value = 1
var current_value = 0

func _ready():
	$TextureRect/Label.text = terminal_name
	$TextureProgress.max_value = max_value
	$TextureProgress.value = current_value

func set_value(value):
	current_value = value
	$TextureProgress.value = value

func set_endagered(is_endangered):
	pass

func set_done(is_done):
	pass
