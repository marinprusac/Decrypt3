extends Resource
class_name MessageData

var title
var content
var icon

func _init(title, content, icon):
	self.title = title
	self.content = content
	self.icon = icon
