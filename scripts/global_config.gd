extends Node

class_name GlobalConfig

var camera_id = 0
var is_camera_mouse_paused = false
var window_mode = 0 # TODO: modify this varible in configurations
var general_sound = 1
var music = 1
var sfx = 1
var control_computer_window_position = null
var first_time = true
var config_window_id = 1
var contrl_window_size = Vector2(362, 475)
var window_size_value = 0
var alpha_opacity = 255

#do not save this
var invite_mode=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_saved_config():
	var config = DataSaver.load_settings_by_id(CurrentProfile.id)
	if config != null:
		camera_id = config.get("camera_id")
		window_mode = config.get("window_mode")
		general_sound = config.get("general_sound")
		music = config.get("music")
		sfx = config.get("sfx")

func save_configs():
	var config = {
		"camera_id": camera_id,
		"window_mode": window_mode,
		"general_sound": general_sound,
		"music": music,
		"sfx": sfx,
		 "control_computer_window_position": control_computer_window_position,
		"first_time": first_time,
		"config_window_id": config_window_id,
		"contrl_window_size": [contrl_window_size[0],contrl_window_size[1]],
		"window_size_value": window_size_value,
		"alpha_opacity": alpha_opacity
	}
	if GlobalConf.invite_mode:
		DataSaver.save_settings(config, CurrentProfile.id)
	else:
		ApiDataSaver.save_settings(config, CurrentProfile.id)

func set_from_json(json):
	camera_id = json.get("camera_id")
	window_mode = json.get("window_mode")
	general_sound = json.get("general_sound")
	music = json.get("music")
	sfx = json.get("sfx")
	control_computer_window_position = json.get("control_computer_window_position")
	first_time = json.get("first_time")
	config_window_id = json.get("config_window_id")
	var aux_size = json.get("contrl_window_size")
	contrl_window_size = Vector2(aux_size[0],aux_size[1])
	window_size_value = json.get("window_size_value")
	alpha_opacity = json.get("alpha_opacity")
	apply_configs()

func apply_configs():
	set_window_mode()
	set_sound_setting()

func set_window_mode():
	match window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func set_sound_setting():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(general_sound))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx))
