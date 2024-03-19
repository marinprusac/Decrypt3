extends Resource
class_name PortData

var name: String
var password: String
var solved: bool


func _init(name, password):
	self.name = name
	self.password = password
	solved = false
