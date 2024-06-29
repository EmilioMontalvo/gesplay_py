extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	#if UdPServer.is_ready and CameraList.is_ready:
		MenuManager.load_menu(11)
