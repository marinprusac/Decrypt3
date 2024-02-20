extends Node2D

export var length: int
export var spacing: int

export var a = []
var digits = []
var typed_digits = []

export var digit_preload = preload("res://DigitDisplay/Digit.tscn")

func _ready():
	pass


func write(new_digits: String):
	clear()
	for c in new_digits:
		key_pressed(int(c))

func clear():
	while not typed_digits.empty():
		erase()

func key_pressed(key):
	if key < 0 or key > 9:
		return
	if len(typed_digits) >= length:
		return
	var new_digit: Sprite = digit_preload.instance()
	new_digit.texture = digits[key]
	new_digit.position = Vector2.RIGHT * spacing * (len(typed_digits) + 0.5*(1-length)) 
	$DigitField.add_child(new_digit)
	typed_digits.append(new_digit)

func erase():
	if len(typed_digits) <= 0:
		return
	var digit_to_remove = typed_digits.pop_back()
	digit_to_remove.queue_free()

		
