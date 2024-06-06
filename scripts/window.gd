extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	# DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 1)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_enhanced_camera_go_back():
	DisplayServer.window_set_mode(2,0)
	DisplayServer.window_move_to_foreground(1)	
	visible=false
	
