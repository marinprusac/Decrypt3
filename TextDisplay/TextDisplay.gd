extends Node2D

export var length: int
var content = ""
onready var label = get_node("Label")

func _ready():
	label.text = "_".repeat(length)

func write(text: String):
	if len(text) >  length:
		content = text.substr(0, length)
	else:
		content = text
	update_text()

func append(text: String):
	if len(text) >  length-len(content):
		content = content + text.substr(0, length-len(content))
	else:
		content = content + text
	update_text()

func clear():
	content = ""
	update_text()

func erase():
	if len(content) == 0:
		return
	content = content.substr(0, len(content)-1)
	update_text()

func update_text():
	label.text = content + "_".repeat(length-len(content))
