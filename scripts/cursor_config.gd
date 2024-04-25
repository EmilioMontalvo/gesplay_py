extends Node


class_name CursorConfig

var camera_id=0
var spd_up=40
var spd_down=40
var spd_left=40
var spd_right=40
var pointer_smooth=63
var tick_interval_ms=16


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
