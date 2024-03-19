extends Resource
class_name MessageData

var title: String
var content: String
var icon: String

func _init(title, content, icon):
	self.title = title
	self.content = content
	self.icon = icon
