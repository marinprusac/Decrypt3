extends Resource
class_name EffectData

var name: String
var permanent: bool
var start
var end

func _init(name, permanent, duration=null):
	self.name = name
	self.permanent = permanent
	self.start = Time.get_unix_time_from_system()
	if not permanent:
		self.end = self.start+duration
