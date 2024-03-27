extends Node

var server = null
var clients = []

var client_to_name = {}
var name_to_client = {}

var name_to_code = {}
var code_to_name = {}


const PORT = 9080
var _server = WebSocketServer.new()

func _ready():
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")
	_server.connect("data_received", self, "_on_data")
	# Start listening on the given port.
	var err = _server.listen(PORT, PoolStringArray(), false)
	if err != OK:
		print("Unable to start server")
		set_process(false)
	else:
		print("Started on port: ", PORT)

func _connected(id, proto):
	print("Client %d connected with protocol: %s" % [id, proto])
	clients.append(id)

func _close_request(id, code, reason):
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])
	remove_client(id)

func _disconnected(id, was_clean = false):
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])
	remove_client(id)


func _on_data(id):
	var pkt = _server.get_peer(id).get_packet()
	var message = pkt.get_string_from_utf8()
	print("Got data from client %d" % id)
	handle(id, message)
	
func _process(delta):
	_server.poll()


func remove_client(id):
	clients.erase(id)
	if id in client_to_name.keys():
		var pname = client_to_name[id]
		name_to_client.erase(pname)
	client_to_name.erase(id)
	if id == server:
		print("Server removed!")
		server = null


func get_data_from_raw(raw):
	return JSON.parse(raw).result

func get_raw_from_data(data):
	return JSON.print(data).to_utf8()

func handle(id, message):
	var data = get_data_from_raw(message)
	
	var type = data["packet_type"]
	var content = data["packet_content"]
	
	if type == "server_connect":
		print("Server initialized!")
		server = id

	elif type == "player_codes":
		name_to_code = content
		print(content)
		for name in name_to_code.keys():
			var code = name_to_code[name]
			code_to_name[code] = name

	elif type == "login":
		var code = content
		if code in code_to_name.keys():
			var pname = code_to_name[code]
			client_to_name[id] = pname
			name_to_client[pname] = id
			send(server, {"packet_type": "joined", "packet_content": {}, "player": pname})

	else:
		if id == server:
			var pname = data["player"]
			if pname in name_to_client.keys():
				var client_id = name_to_client[pname]
				send(client_id, data)
		elif server != null:
			var pname = client_to_name[id]
			data["player"] = pname
			send(server, data)
			

func send(id, data):
	var peer = _server.get_peer(id)
	var packet = get_raw_from_data(data)
	peer.put_packet(packet)
	print("Data sent.")
