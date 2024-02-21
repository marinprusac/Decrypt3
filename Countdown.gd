extends Node2D


export var minutes = 1
export var seconds = 0


func _ready():
	pass

func second_passed():
	
	seconds -= 1
	if seconds < 0:
		seconds += 59
		minutes -= 1
	if seconds == 0 and minutes == 0:
		$Timer.stop()
	show_time()

func show_time():
	var text = str(minutes) + str(seconds)
	$TextDisplay.write(text)


func _process(delta):
	pass
