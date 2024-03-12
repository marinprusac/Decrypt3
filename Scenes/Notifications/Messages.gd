extends Control

signal exited_messages()


var texture_dict = {
	"Hack": preload("res://Art/Abilities/hack.png"),
	"Protect": preload("res://Art/Abilities/protect.png"),
	"Scan": preload("res://Art/Abilities/scan.png"),
	"Password": preload("res://Art/Abilities/password.png"),
	"Backdoor": preload("res://Art/Abilities/backdoor.png")
}


var messages_data: Array = []

func initialize(welcome_packet):
	messages_data = welcome_packet["messages"]
	re_add()

func refresh(new_message):
	messages_data.append(new_message)
	re_add()

func re_add():
	$ItemList.clear()
	for i in range(len(messages_data)):
		var index = len(messages_data)-1-i
		var message_packet = messages_data[index]
		add_item(message_packet)
		

func add_item(message_packet):
	var icon = message_packet["icon"]
	var title = message_packet["title"]
	var content = message_packet["content"]
	
	var texture = texture_dict[icon]
	
	$ItemList.add_item(title, texture)
	

func _on_select(index):
	$Popup.open_message(messages_data[index])

func _on_deselect():
	deselect_all()

func deselect_all():
	print("des")
	$ItemList.unselect_all()

func enter():
	visible = true

func _on_exit():
	visible = false
	$Popup.visible = false
	deselect_all()
	emit_signal("exited_messages")

