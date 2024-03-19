extends Label

var safe_color = Color(.25, .75, .25, 1)
var trouble_color = Color(.75, .25, .25, 1)

func start(end_time):
	refresh(end_time)

func refresh(end_time):
	text = get_print(end_time)

func end(victory):
	text = "Nuclear Launcher DECRYPTED!" if victory else "Nuclear Launcher SEIZED!"
	modulate = safe_color if victory else trouble_color


func get_print(end_time):
	var now = Time.get_unix_time_from_system()
	var seconds_left = end_time - now
	var seconds = int(seconds_left)
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

