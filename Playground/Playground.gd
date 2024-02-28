extends Control




func _ready():
	var packet = JSON.print({
		"packet_type": "welcome",
		"packet_data" : {
			"you": {
				"name": "Marin",
				"role": "Red Team Whitehat",
				"hacked": false,
				"backdoored": true,
			},
			"players": [
				"Marin",
				"Jelena",
				"Patrik",
				"Mauro",
				"Luka"
			],
			"abilities": {
				"hack": {
					"usable": true,
					"last_target": null,
					"on_cooldown": true,
					"start_cooldown": 13000,
					"end_cooldown": 17000
				},
				"protect": {
					"usable": true,
					"last_target": null,
					"on_cooldown": null,
					"start_cooldown": null,
					"end_cooldown": null
				}
			},
			"terminals": [
				{
					"name": "A",
					"solved": false,
					"port_passwords": ["", "", "23"]
				},
				{
					"name": "B",
					"solved": false,
					"port_passwords": ["11", "", "00"]
				}
			],
			"messages": [
				{
					"type": "Hack Action",
					"title": "Hack: Jelena",
					"content": "You successfully hacked Jelena!"
				},
				{
					"type": "Terminal Decrypt",
					"title": "Terminal A Decrypted",
					"content": "Terminal A has been successfully decrypted."
				}
			]
		}
	})
	
	
	var data2: JSONParseResult = JSON.parse(packet)
	
	var res = data2.result
	
	print(res["packet"]["abilities"]["hack"]["usable"])
	

	
