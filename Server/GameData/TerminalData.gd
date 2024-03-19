extends Resource
class_name TerminalData


var name: String
var ports: Array
var endangered: bool
var solved: bool

func _init(name, port_count, digits_per_port):
	endangered = false
	solved = false
	ports = []
	self.name = name
	
	randomize()
	
	for i in range(port_count):
		var password = str(randi() % 10^digits_per_port)
		
		for j in range(digits_per_port-len(password)):
			password = "0" + password
		
		ports.append(PortData.new(name + str(i+1), password))
