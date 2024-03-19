extends TextureRect

export var whitehat = false
export var blackhat = false

func _ready():
	if whitehat:
		$Whitehat.visible = true
	if blackhat:
		$Blackhat.visible = true

func set_backdoored(backdoored: bool):
	material.set("shader_param/backdoored", backdoored)
	material.set("shader_param/random_seed", rand_range(-100,100))
