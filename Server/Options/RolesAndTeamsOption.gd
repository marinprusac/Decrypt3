extends VBoxContainer

var currently_changing = "red"
var last_changed = "blue"
var to_modify = "yellow"

var code_changing = false

func _fix_to_modify():
	for color in ["red", "blue", "yellow"]:
		if not color in [currently_changing, last_changed]:
			to_modify = color

func _get_color(color):
	if color == "red":
		return $TeamDistribution/RedSlider.value
	if color == "blue":
		return $TeamDistribution/BlueSlider.value
	if color == "yellow":
		return $TeamDistribution/YellowSlider.value

func _set_color(color, value):
	code_changing = true
	if color == "red":
		$TeamDistribution/RedSlider.value = value
	if color == "blue":
		$TeamDistribution/BlueSlider.value = value
	if color == "yellow":
		$TeamDistribution/YellowSlider.value = value
	code_changing = false

func _on_red_value_changed(value):
	$TeamDistribution/RedLabel.text = MyTools.print_percentage(value)
	if code_changing:
		return
	_fix_values("red", value)

func _on_blue_value_changed(value):
	$TeamDistribution/BlueLabel.text = MyTools.print_percentage(value)
	if code_changing:
		return
	_fix_values("blue", value)
	
func _on_yellow_value_changed(value):
	$TeamDistribution/YellowLabel.text = MyTools.print_percentage(value)
	if code_changing:
		return
	_fix_values("yellow", value)
	
func _fix_values(current_color, value):
	if currently_changing != current_color:
		last_changed = currently_changing
		currently_changing = current_color
		_fix_to_modify()
	var last_val = _get_color(last_changed)
	if last_val + value <= 1:
		_set_color(to_modify, 1-last_val-value)
	else:
		_set_color(to_modify, 0)
		_set_color(last_changed, 1-value)

func _on_whitehat_value_changed(value):
	var wh_label = $RoleDistribution/WhitehatLabel
	wh_label.text = MyTools.print_percentage(value)
	
	var bh_slider = $RoleDistribution/BlackhatSlider
	var total = bh_slider.value + value
	if total != 1:
		bh_slider.value = 1-value

func _on_blackhat_value_changed(value):
	var bh_label = $RoleDistribution/BlackhatLabel
	bh_label.text = MyTools.print_percentage(value)
	
	var wh_slider = $RoleDistribution/WhitehatSlider
	var total = wh_slider.value + value
	if total != 1:
		wh_slider.value = 1-value
