extends GridContainer

onready var hacker_preload = preload("res://Server/Gameplay/HackerRepresentation.tscn")

func make_hackers(whitehats: int, blackhats: int):
	for child in get_children():
		child.queue_free()
	var blackhats_left = blackhats
	for i in range(whitehats+blackhats):
		var new_hacker = hacker_preload.instance()
		new_hacker.material = new_hacker.material.duplicate()
		new_hacker.whitehat = blackhats_left == 0
		new_hacker.blackhat = not new_hacker.whitehat
		new_hacker.set_backdoored(blackhats_left==0)
		add_child(new_hacker)
		blackhats_left -= 1 if blackhats_left > 0 else 0

func _ready():
	make_hackers(12, 3)
