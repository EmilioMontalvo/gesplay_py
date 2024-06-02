extends Control

var temporalCursorConfig=CursorConfig.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	temporalCursorConfig.set_from_json(CursorConf.get_as_json())
	$VelocitySlider.set_value(temporalCursorConfig.spd_down)
	$PointerSmootSlider.set_value(temporalCursorConfig.pointer_smooth)
	$TicksSlider.set_value(temporalCursorConfig.tick_interval_ms)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ticks_slider_value_changed(value):
	temporalCursorConfig.tick_interval_ms=value
	send_new_config(temporalCursorConfig)

func _on_pointer_smoot_slider_value_changed(value):
	temporalCursorConfig.pointer_smooth=value
	send_new_config(temporalCursorConfig)

func _on_velocity_slider_value_changed(value):
	temporalCursorConfig.new_speed(value)
	send_new_config(temporalCursorConfig)

func send_new_config(config:CursorConfig):
	UdPServer.send_message(config.get_as_message("update_cursor_config"))


func _on_acept_button_down():
	CursorConf.set_from_json(temporalCursorConfig.get_as_json())
	send_new_config(CursorConf)


func _on_cancel_button_down():
	send_new_config(CursorConf)
