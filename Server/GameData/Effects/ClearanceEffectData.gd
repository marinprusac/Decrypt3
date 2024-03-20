extends EffectData
class_name ClearanceEffectData

var team_color = null

func _init(duration, team_color).("Clearance", false, duration):
	self.team_color = team_color
