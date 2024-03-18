extends Resource
class_name EffectData

var name
var permanent
var start
var end

func _init(name, permanent, start=null, end=null):
	self.name = name
	self.permanent = permanent
	self.start = start
	self.end = end
