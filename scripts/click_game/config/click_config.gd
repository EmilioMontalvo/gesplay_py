extends Node

class_name ClickConfig

var camera_id = 0
var gesture_index = 0

func set_gesture(index: int):
	gesture_index = index
	
func get_as_array() -> Array:
	return [camera_id, gesture_index]

func send_to_camera_mouse():
	pass

func get_as_json() -> Dictionary:
	return {
		"camera_id": camera_id,
		"gesture_index": gesture_index
	}

func set_from_json(config: Dictionary):
	camera_id = config["camera_id"]
	gesture_index = config["gesture_index"]

func get_as_message(instruction: String) -> Message:
	return Message.new(instruction,get_as_json())
