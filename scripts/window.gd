extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	# DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 1)
	$Camera2D/EnhancedCamera.set_window_id(
		DisplayServer.get_window_list()[DisplayServer.get_window_list().size()-1])
	$Camera2D/EnhancedCamera.window=true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_window_id():
	pass


func _on_enhanced_camera_go_back():
	DisplayServer.window_set_mode(0,0)
	DisplayServer.window_move_to_foreground(0)
	$Camera2D/EnhancedCamera.window=false
	visible=false



func _on_confirm_dialog_window_acepted():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
