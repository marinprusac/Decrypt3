extends PopupDialog

signal notice_dismissed()

func on_dismiss():
	visible = false
	emit_signal("notice_dismissed")

func on_select_notice(index):
	visible = true


