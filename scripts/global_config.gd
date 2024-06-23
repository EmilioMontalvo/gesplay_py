extends Node

class_name GlobalConfig

var camera_id=0
var is_camera_mouse_paused=false
var window_mode = 0 #TODO: modify this varible in configurations
var general_sound = 1
var music = 1
var sfx = 1
var control_computer_window_position=null
var first_time=true
var config_window_id=1
var contrl_window_size=Vector2(362,475)
var window_size_value=0
var alpha_opacity=255

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_saved_config():
	var config = DataSaver.load_settings_by_id(CurrentProfile.id)
	if config!=null:
		camera_id = config.get("camera_id")
		window_mode = config.get("window_mode")
		general_sound = config.get("general_sound")
		music = config.get("music")
		sfx = config.get("sfx")

func save_configs():
	var config = {
		"camera_id":camera_id,
		"window_mode":window_mode,
		"general_sound":general_sound,
		"music":music,
		"sfx":sfx
	}
	DataSaver.save_settings(config, CurrentProfile.id)
