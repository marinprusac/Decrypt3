extends Control

signal options_saved(settings)
signal done()

func get_settings():
	var settings = Settings.new()
	
	var player_count = $Players/PlayerList.get_item_count()
	var codes = MyTools.generate_random_codes(player_count, 3)
	var player_codes = {}
	for i in range(player_count):
		player_codes[codes[i]] = $Players/PlayerList.get_item_text(i)
	settings.player_codes = player_codes
	
	settings.whitehat_percent = $RolesAndTeams/RoleDistribution/WhitehatSlider.value
	settings.blackhat_percent = $RolesAndTeams/RoleDistribution/BlackhatSlider.value
	settings.red_team_percent = $RolesAndTeams/TeamDistribution/RedSlider.value
	settings.blue_team_percent = $RolesAndTeams/TeamDistribution/BlueSlider.value
	settings.yellow_team_percent = $RolesAndTeams/TeamDistribution/YellowSlider.value
	
	var unit_in_seconds = 1
	var item = $Durations/TimeUnit/UnitOptionButton.get_item_text($Durations/TimeUnit/UnitOptionButton.selected)
	if item == "minutes":
		unit_in_seconds = 60
	elif item == "hours":
		unit_in_seconds = 60*60
	elif item == "days":
		unit_in_seconds = 60*60*24
	settings.base_time_unit_seconds = unit_in_seconds * int($Durations/TimeUnit/ValueLineEdit.text)
	
	settings.ability_cooldown_units = $Durations/CooldownDuration/AbilitySlider.value
	settings.expertise_cooldown_units = $Durations/CooldownDuration/ExpertiseSlider.value
	settings.special_cooldown_units = $Durations/CooldownDuration/SpecialSlider.value
	
	settings.hacked_duration_units = $Durations/EffectDuration/HackedSlider.value
	settings.forged_duration_units = $Durations/EffectDuration/ForgedSlider.value
	settings.protection_duration_units = $Durations/EffectDuration/ProtectionSlider.value
	settings.clearance_duration_units = $Durations/EffectDuration/ClearanceSlider.value
	
	settings.game_duration_units = $Durations/GameDuration/InitialSlider.value
	settings.game_duration_increment_units = $Durations/GameDuration/IncrementSlider.value
	
	settings.terminal_count = $Terminals/GridContainer/TerminalCountSlider.value
	settings.ports_per_terminal = $Terminals/GridContainer/PortCountSlider.value
	settings.digits_per_port = $Terminals/GridContainer/DigitCountSlider.value
	
	return settings

func enter():
	visible = true

func _on_save_options():
	var settings = get_settings()
	visible = false
	emit_signal("options_saved", settings)
	emit_signal("done")

func _ready():
	enter()
