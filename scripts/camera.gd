extends TextureRect

@export var is_aux=false
var pauseTexture=load("res://assets/paused_camera.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	#640 * 480
	if visible and !is_aux:
		UdPServer.set_cameraTexture(self)
	elif is_aux:
		UdPServer.set_aux_camera(self)
	
	if GlobalConf.is_camera_mouse_paused:
		texture=pauseTexture

func _process(_delta):
	if GlobalConf.is_camera_mouse_paused:
		set_texture(pauseTexture)


