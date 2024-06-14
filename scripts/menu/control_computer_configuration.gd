extends Control

var factor=0.05
var aspect_ratio = 362/475
var window_actual_size = Vector2(362,475)
var window_invisble_camera_size=Vector2(362,475)
var camera_visible=true

var user_size
var config_size
var size_value

signal cancel
signal opacity_changed

func _ready():
	user_size=GlobalConf.contrl_window_size
	$Panel/SizeSlider.value=GlobalConf.window_size_value
	size_value=GlobalConf.window_size_value
	
	$Panel/OpacitySlider.value=GlobalConf.alpha_opacity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_accept_button_pressed():
	user_size=config_size
	GlobalConf.contrl_window_size=user_size
	GlobalConf.window_size_value=size_value
	cancel.emit()


func _on_cancel_button_pressed():
	DisplayServer.window_set_size(user_size,GlobalConf.config_window_id)
	$Panel/SizeSlider.value=GlobalConf.window_size_value
	size_value=GlobalConf.window_size_value
	cancel.emit()



func _on_size_slider_value_changed(value):
	
	# Calculate the new width and height while maintaining the aspect ratio
	var new_width = window_actual_size.x + (value * factor * 362)
	var new_height = window_actual_size.y + (value * factor * 475)
	config_size=Vector2i(new_width, new_height)
	# Set the new window size
	size_value=value
	DisplayServer.window_set_size(config_size, GlobalConf.config_window_id)

func _on_opacity_slider_value_changed(value):
	opacity_changed.emit(value)


	


