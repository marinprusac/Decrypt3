extends Control
class_name Keyboard

signal digit_pressed(key)
signal digit_erased()
signal enter()

func press_0():
	press(KEY_0)
func press_1():
	press(KEY_1)
func press_2():
	press(KEY_2)
func press_3():
	press(KEY_3)
func press_4():
	press(KEY_4)
func press_5():
	press(KEY_5)
func press_6():
	press(KEY_6)
func press_7():
	press(KEY_7)
func press_8():
	press(KEY_8)
func press_9():
	press(KEY_9)
func press_enter():
	press(KEY_ENTER)
func press_erase():
	press(KEY_BACKSPACE)

func press(key):
	if key == KEY_ENTER:
		emit_signal("enter")
	elif key == KEY_BACKSPACE:
		emit_signal("digit_erased")
	else:
		emit_signal("digit_pressed", str(key-48))


var keys = [KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_ENTER, KEY_BACKSPACE]
var pressed = []
