extends Window

var save_opacity
var temp_opacity
# Called when the node enters the scene tree for the first time.
func _ready():
	# DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 1)
	var window_id=DisplayServer.get_window_list()[DisplayServer.get_window_list().size()-1]
	if window_id!=0:
		$Camera2D/EnhancedCamera.set_window_id(window_id)
		$Camera2D/EnhancedCamera.window=true
		GlobalConf.config_window_id=window_id
	set_content_scale_size(Vector2i(362,475))
	
	if GlobalConf.contrl_window_size:
		size=GlobalConf.contrl_window_size
	
	save_opacity=GlobalConf.alpha_opacity
	$Camera2D/CanvasModulate.color.a=GlobalConf.alpha_opacity/255
	
	if not GlobalConf.control_computer_window_position:
		var primary_screen_index = DisplayServer.window_get_current_screen()
		# Get the size of the primary screen
		var screen_size = DisplayServer.screen_get_size(primary_screen_index)
		GlobalConf.control_computer_window_position=screen_size-DisplayServer.window_get_size(window_id)
	
	if window_id!=0:
		DisplayServer.window_set_position(GlobalConf.control_computer_window_position,window_id)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.

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


func _on_enhanced_camera_config(windowId):
	$ConfigurationWindow.visible=true
	$ConfigurationWindow.update_son()


func _on_control_computer_configuration_opacity_changed(value):
	temp_opacity=value
	$Camera2D/CanvasModulate.color.a=value/255
	GlobalConf.alpha_opacity=value
	

func _on_control_computer_configuration_cancel():
	GlobalConf.alpha_opacity=save_opacity
	$Camera2D/CanvasModulate.color.a=save_opacity/255


func _on_visibility_changed():
	if visible:
		_ready()
