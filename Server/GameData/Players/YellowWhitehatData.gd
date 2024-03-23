extends WhitehatData
class_name YellowWhitehatData

func _init(name, reg_cd, exp_cd, hack_duration, forge_duration, protection_duration).(name, "Yellow Team", exp_cd):
	abilities.append(HackAbilityData.new(reg_cd, hack_duration, forge_duration))
	abilities.append(ProtectAbilityData.new(reg_cd, protection_duration))
	abilities.append(ScanAbilityData.new(exp_cd))

func is_team(color):
	return color == "yellow"
