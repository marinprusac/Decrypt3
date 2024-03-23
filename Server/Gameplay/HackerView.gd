extends GridContainer

onready var hacker_preload = preload("res://Server/Gameplay/HackerRepresentation.tscn")

func initialize(game_data: GameData):
	for child in get_children():
		child.queue_free()
	for player in game_data.players:
		player = player as PlayerData
		var new_hacker = hacker_preload.instance()
		new_hacker.name = player.name
		new_hacker.material = new_hacker.material.duplicate()
		new_hacker.blackhat = player.role == "Blackhat"
		new_hacker.whitehat = player.role != "Blackhat"
		add_child(new_hacker)

func handle_changes(game_data: GameData):
	for player in game_data.players:
		player = player as PlayerData
		var child = get_node(player.name)
		if player.has_effect("Backdoored"):
			child.set_backdoored(true)
		else:
			child.set_backdoored(false)
