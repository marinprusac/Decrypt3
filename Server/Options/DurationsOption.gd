extends VBoxContainer

func _on_value_changed(new_text):
	var int_val = str(abs(int(new_text)))
	$TimeUnit/ValueLineEdit.text = int_val
	$TimeUnit/ValueLineEdit.caret_position = len(int_val)

func _on_initial_value_changed(value):
	$GameDuration/InititalValueLabel.text = str(value)

func _on_increment_value_changed(value):
	$GameDuration/IncrementValueLabel.text = str(value)

func _on_ability_value_changed(value):
	$CooldownDuration/AbilityValueLabel.text = str(value)

func _on_expertise_value_changed(value):
	$CooldownDuration/ExpertiseValueLabel.text = str(value)

func _on_special_value_changed(value):
	$CooldownDuration/SpecialValueLabel.text = str(value)

func _on_hacked_value_changed(value):
	$EffectDuration/HackedValueLabel.text = str(value)

func _on_forged_value_changed(value):
	$EffectDuration/ForgedValueLabel.text = str(value)

func _on_protection_value_changed(value):
	$EffectDuration/ProtectionValueLabel.text = str(value)

func _on_clearance_value_changed(value):
	$EffectDuration/ClearanceValueLabel.text = str(value)
