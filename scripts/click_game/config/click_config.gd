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
	apply_config()

func get_as_message(instruction: String) -> Message:
	return Message.new(instruction,get_as_json())

func load_saved_config():
	var config = DataSaver.load_settings_by_id(CurrentProfile.id)
	if config != null:
		set_from_json(config)
		return true

func save_config():
	DataSaver.save_settings(get_as_json(),CurrentProfile.id)

func apply_config():
	UdPServer.send_message(get_as_message("update_click_config"))
