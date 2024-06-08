extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	# DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 1)
	var window_id=DisplayServer.get_window_list()[DisplayServer.get_window_list().size()-1]
	$Camera2D/EnhancedCamera.set_window_id(window_id)
	$Camera2D/EnhancedCamera.window=true
	if window_id!=0:
		DisplayServer.window_set_position(GlobalConf.control_computer_window_position,window_id)
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
	save_position()



func _on_confirm_dialog_window_acepted():
	get_tree().quit()
	save_position()


func _on_confirm_dialog_window_canceled():
	$ConfirmDialogWindow.visible=false
	save_position()

func save_position():
	GlobalConf.control_computer_window_position=position
