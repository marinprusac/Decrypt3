extends Control

signal options_saved(settings)


func _on_save_options():
	var settings = Settings.new()
	emit_signal("options_saved", settings)
