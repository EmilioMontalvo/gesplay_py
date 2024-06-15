extends Button

var paused=GlobalConf.is_camera_mouse_paused
# Called when the node enters the scene tree for the first time.
func _ready():
	set_icon()



func _on_pressed():
	set_icon()
	if not paused:
		UdPServer.send_message(Message.new("pause_mouse",{"info": "mouse paused"}))
	else: 
		UdPServer.send_message(Message.new("resume_mouse",{"info": "mouse resumed"}))
	
	paused=not paused
	GlobalConf.is_camera_mouse_paused=paused

func set_icon():
	$PauseTexture.visible=not GlobalConf.is_camera_mouse_paused
	$ContinueTexture.visible=GlobalConf.is_camera_mouse_paused
