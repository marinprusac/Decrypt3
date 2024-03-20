extends VBoxContainer

func _on_add_player():
	var player_name = $PlayerAdder/NameLineEdit.text
	var list = $PlayerList
	$PlayerAdder/NameLineEdit.clear()
	
	if len(player_name) == 0:
		return
	
	for i in range(list.get_item_count()):
		var another_name = list.get_item_text(i)
		if player_name == another_name:
			return
	
	list.add_item(player_name)

func _on_player_deleted(index):
	var list = $PlayerList
	list.remove_item(index)
