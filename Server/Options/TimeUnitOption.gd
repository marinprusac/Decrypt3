extends HBoxContainer

func _on_value_changed(new_text):
	var int_val = str(abs(int(new_text)))
	$ValueLineEdit.text = int_val
	$ValueLineEdit.caret_position = len(int_val)
