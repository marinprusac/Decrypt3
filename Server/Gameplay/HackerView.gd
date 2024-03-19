extends GridContainer

onready var hacker_preload = preload("res://Server/Gameplay/HackerRepresentation.tscn")

func initialize(players: Array):
	for child in get_children():
		child.queue_free()
	for player in players:
		player = player as PlayerData
		var new_hacker = hacker_preload.instance()
		new_hacker.name = player.name
		new_hacker.material = new_hacker.material.duplicate()
		new_hacker.blackhat = player.role == "Blackhat"
		new_hacker.whitehat = player.role != "Blackhat"
		add_child(new_hacker)

func refresh(players: Array):
	for player in players:
		player = player as PlayerData
		var child = get_node(player.name)
		for effect in player.effects:
			if effect.name == "Backdoored":
				child.set_backdoored(true)
		child.set_backdoored(false)
