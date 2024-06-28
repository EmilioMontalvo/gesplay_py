extends Node


class_name CursorConfig

var camera_id=0
var spd_up=10
var spd_down=10
var spd_left=10
var spd_right=10
var pointer_smooth=65
var tick_interval_ms=16

func new_speed(speed):
	spd_up=speed
	spd_down=speed
	spd_left=speed
	spd_right=speed

func get_as_array():
	return [camera_id, spd_up, spd_down, spd_left, spd_right, pointer_smooth,tick_interval_ms]

func send_to_camera_mouse():
	pass

func get_as_json():
	var config = {
		"camera_id": camera_id,
		"spd_up": spd_up,
		"spd_down": spd_down,
		"spd_left": spd_left,
		"spd_right": spd_right,
		"pointer_smooth": pointer_smooth,
		"tick_interval_ms": tick_interval_ms
	}
	
	return config

func set_from_json(config: Dictionary):
	camera_id = config["camera_id"]
	spd_up = config["spd_up"]
	spd_down = config["spd_down"]
	spd_left = config["spd_left"]
	spd_right = config["spd_right"]
	pointer_smooth = config["pointer_smooth"]
	tick_interval_ms = config["tick_interval_ms"]

func get_as_message(instruction:String):
	return Message.new(instruction,get_as_json())

func send_update_to_upd():
	UdPServer.send_message(get_as_message("update_cursor_config"))

func save_config():
	DataSaver.save_settings(get_as_json(),CurrentProfile.id)

