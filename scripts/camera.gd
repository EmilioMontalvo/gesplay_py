extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	#640 * 480
	UdPServer.set_cameraTexture(self)



