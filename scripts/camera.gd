extends TextureRect

var pauseTexture=load("res://assets/paused_camera.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	#640 * 480
	UdPServer.set_cameraTexture(self)
	if GlobalConf.is_camera_mouse_paused:
		texture=pauseTexture

func _process(delta):
	if GlobalConf.is_camera_mouse_paused:
		set_texture(pauseTexture)


