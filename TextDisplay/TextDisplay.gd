extends Node2D

export var length: int
export var spacing: int

var typed_digits = []

func full():
	return len(typed_digits) >= length

func get_object(key):
	var ascii_val = key.to_ascii()[0]
	if ascii_val >= 48 and ascii_val <= 57:
		var num_index = ascii_val - 48
		var obj = $CharacterSet/Digits.get_child(num_index)
		return obj
	elif ascii_val >= 65 and ascii_val <= 90:
		var letter_index = ascii_val - 65
		var obj = $CharacterSet/Letters.get_child(letter_index)
		return obj
	return null



func write(new_digits: String):
	clear()
	append(new_digits)

func append(new_digits: String):
	for key in new_digits:
		if full():
			return
		var obj = get_object(key)
		var new_obj = obj.duplicate()
		new_obj.position = Vector2.RIGHT * \
		((1-length)*spacing/2 + len(typed_digits) * spacing)
		typed_digits.append(new_obj)
		$TextField.add_child(new_obj)
		

func clear():
	while not typed_digits.empty():
		erase()

func erase():
	if len(typed_digits) <= 0:
		return
	var digit_to_remove = typed_digits.pop_back()
	digit_to_remove.queue_free()

		
