extends PlayerData
class_name WhitehatData

func _init(name, team, exp_cd).(name, team + " Whitehat"):
	abilities.append(CrackAbilityData.new(exp_cd))
