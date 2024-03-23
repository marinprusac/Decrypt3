extends Control

signal exited_messages()


var texture_dict = {
	"hack": preload("res://Art/Abilities/hack.png"),
	"protect": preload("res://Art/Abilities/protect.png"),
	"scan": preload("res://Art/Abilities/scan.png"),
	"password": preload("res://Art/Abilities/password.png"),
	"backdoor": preload("res://Art/Abilities/backdoor.png")
}


var data: KnownData

func enter():
	visible = true

func initialize(data: KnownData):
	self.data = data
	re_add()

func _on_disconnected():
	data = null
	re_add()
	visible = false

func _on_new_message(msg):
	deselect_all()
	add_item(msg)
	re_add()

func refresh():
	pass

func _on_game_state_changed(game_state):
	if game_state == data.GameState.PREP:
		pass
	elif game_state == data.GameState.RUNNING:
		pass
	elif game_state == data.GameState.PAUSED:
		pass
	elif game_state == data.GameState.ENDED:
		deselect_all()
		visible = false

func re_add():
	$ItemList.clear()
	for i in range(len(data.messages)):
		var index = len(data.messages)-1-i
		var message_packet = data.messages[index]
		add_item(message_packet)
		

func add_item(message_packet):
	var icon = message_packet["icon"]
	var title = message_packet["title"]
	var content = message_packet["content"]
	
	var texture = texture_dict[icon]
	
	$ItemList.add_item(title, texture)
	

func _on_select(index):
	$Popup.open_message(data.messages[len(data.messages)-1-index])

func _on_deselect():
	deselect_all()

func deselect_all():
	print("des")
	$ItemList.unselect_all()

func _on_exit():
	visible = false
	$Popup.visible = false
	deselect_all()
	emit_signal("exited_messages")

