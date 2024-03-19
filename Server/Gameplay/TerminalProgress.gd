extends Control

var max_value = 1
var current_value = 0
var done = false
var endangered = false

func _ready():
	$TextureRect/Label.text = name
	$TextureProgress.max_value = max_value
	$TextureProgress.value = current_value

func set_value(value):
	if done:
		return
	current_value = value
	$TextureProgress.value = value
	material.set("shader_param/progressed", current_value == max_value)

func set_endangered(is_endangered):
	if done:
		return
	if endangered == is_endangered:
		return
	endangered = is_endangered
	material.set("shader_param/endangered", endangered)
	

func set_done(is_done):
	if done == is_done:
		return
	done = is_done
	modulate = Color(.5, 1, .5, .5) if done else Color(1, 1, 1, 1)
	endangered = endangered and not done
	material.set("shader_param/endangered", endangered and not done)
	material.set("shader_param/progressed", current_value == max_value and not done)
