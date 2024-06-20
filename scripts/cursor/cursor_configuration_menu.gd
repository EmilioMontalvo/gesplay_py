extends Control

var temporalCursorConfig=CursorConfig.new()
var temporalCursorIconConfig=CustomCursor.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	temporalCursorConfig.set_from_json(CursorConf.get_as_json())
	temporalCursorIconConfig.set_from_json(CursorIconConf.get_as_json())
	$VelocitySlider.set_value(temporalCursorConfig.spd_down)
	$PointerSmootSlider.set_value(temporalCursorConfig.pointer_smooth)
	$TicksSlider.set_value(temporalCursorConfig.tick_interval_ms)
	$SizeSlider.set_value(temporalCursorIconConfig.size)
	$OpacitySlider.set_value(temporalCursorIconConfig.opacity)


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
	MenuManager.load_menu(4)


func _on_cancel_button_down():
	CursorIconConf.set_from_json(temporalCursorIconConfig.get_as_json())
	CursorIconConf.send_update_to_upd()
	send_new_config(CursorConf)
	MenuManager.load_menu(4)
	


func _on_size_slider_value_changed(value):
	CursorIconConf.size=value
	CursorIconConf.send_update_to_upd()


func _on_opacity_slider_value_changed(value):
	CursorIconConf.opacity=value
	CursorIconConf.send_update_to_upd()


func _on_color_picker_button_color_changed(color):
	CursorIconConf.color=color
	CursorIconConf.send_update_to_upd()
