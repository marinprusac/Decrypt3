extends Control




func _ready():
	

	
	
	var packet = JSON.print(
		{
			"terminals": 
				[
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
				]
		}
	)
	
	
	var data2: JSONParseResult = JSON.parse(packet)
	
	var res = data2.result
	
	print(res["terminals"][0].solved)
	

	
