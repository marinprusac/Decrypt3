extends Node

var _client = WebSocketClient.new()

signal trying_to_connect()
signal connected()
signal failed_to_connect()
signal disconnected()

signal packet_received(packet)

var url: String = "onedecrypt.tech"
var port: int = 9080

var websocket_url = "ws://" + url + ":" + str(port)

func try_connect():
	emit_signal("trying_to_connect")
	var err = _client.connect_to_url(websocket_url, PoolStringArray(), false)
	if err != OK:
		print("Unable to connect")
		emit_signal("failed_to_connect")
		
func force_disconnect():
	_client.disconnect_from_host()

func send(packet):
	_client.get_peer(1).put_packet(MyTools.get_raw_from_data(packet))

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	emit_signal("disconnected")
	
func _connected(proto = ""):
	print("Connected.", proto)
	emit_signal("connected")
	
func _on_data():
	var message = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Data received.")
	emit_signal("packet_received", MyTools.get_data_from_raw(message))

func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")
	try_connect()

func _process(_delta):
	_client.poll()
