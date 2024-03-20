extends VBoxContainer

func _on_terminal_value_changed(value):
	$GridContainer/TerminalCountValueLabel.text = str(value)


func _on_port_value_changed(value):
	$GridContainer/PortCountValueLabel.text = str(value)


func _on_digit_value_changed(value):
	$GridContainer/DigitCountValueLabel.text = str(value)
