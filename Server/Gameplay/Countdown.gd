extends Label

signal game_over()

export var starting_seconds = 3600
var current_seconds = starting_seconds


func get_print():
	var seconds = current_seconds
	var minutes = int(seconds/60)
	seconds = seconds%60
	var hours = int(minutes/60)
	minutes = minutes%60
	
	var txt = ""
	if hours < 10:
		txt += "0"
	txt += str(hours)
	txt += ":"
	if minutes < 10:
		txt += "0"
	txt += str(minutes)
	txt += ":"
	if seconds < 10:
		txt += "0"
	txt += str(seconds)
	
	return txt


func _ready():
	$Timer.start()

func _on_second_passed():
	current_seconds -= 1
	text = get_print()

	if current_seconds <= 0:
		emit_signal("game_over")
		$Timer.stop()
		return
	



