extends Node

var key_address = "res://Certificates/key.key"
var cert_address = "res://Certificates/cert.crt"

func generate():
	# Create and set key and self-signed certificate.
	var crypto = Crypto.new()
	var key = crypto.generate_rsa(4096)
	var cert = crypto.generate_self_signed_certificate(key, "CN=onedecrypt,O=onedecrypt,C=HR", "10140101000000", "50140101000000")
	
	key.save(key_address)
	cert.save(cert_address)

func validate():
	var key = load(key_address)
	var cert = load(cert_address)

func _ready():
	generate()

