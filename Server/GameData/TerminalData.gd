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

func get_solved_port_count():
	var count = 0
	for port in ports:
		if port.solved:
			count += 1
	return count

func get_port(port_index):
	return ports[port_index] as PortData

func get_dict(targetable: bool, known_ports: Array):
	var port_passwords = []
	port_passwords.resize(len(ports))
	port_passwords.fill("")
	
	for i in range(len(ports)):
		var port = ports[i]
		if port.name in known_ports:
			port_passwords[i] = port.password
	
	var dict = {
		"crackable": not solved and targetable,
		"solved": solved,
		"port_passwords": port_passwords
	}
	return dict
	
