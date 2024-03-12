extends Label

signal game_over()

export var hours = 1
export var minutes = 0
export var seconds = 0

func _ready():
	$Timer.start()

func _on_second_passed():
	seconds -= 1
	if seconds < 0:
		minutes -= 1
		if minutes < 0:
			hours -= 1
			if hours < 0:
				emit_signal("game_over")
				$Timer.stop()
				return
			minutes += 60
		seconds += 60
	
	var txt = str(hours)
	txt += ":"
	if minutes < 10:
		txt += "0"
	txt += str(minutes)
	txt += ":"
	if seconds < 10:
		txt += "0"
	txt += str(seconds)
	
	text = txt

