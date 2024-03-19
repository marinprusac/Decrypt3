extends Resource
class_name EffectData

var name: String
var permanent: bool
var start
var end

func _init(name, permanent, start=null, end=null):
	self.name = name
	self.permanent = permanent
	self.start = start
	self.end = end
