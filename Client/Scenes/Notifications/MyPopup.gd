extends PopupDialog

signal notice_dismissed()

func open_message(message_packet):
	var type = message_packet["icon"]
	var title = message_packet["title"]
	var content = message_packet["content"]
	$Panel/Title.text = title
	$Description.text = content
	visible = true

func _on_dismiss():
	visible = false
	emit_signal("notice_dismissed")
