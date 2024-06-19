extends Node

class_name CustomCursor

var cursor_id = 0
var size = Vector2(32, 32)
var opacity = 1.0
var color = Color(1, 1, 1, 1)

func new_size(new_size: Vector2):
	size = new_size

func set_opacity(new_opacity: float):
	opacity = new_opacity

func set_color(new_color: Color):
	color = new_color

func get_as_array():
	return [cursor_id, size, opacity, color]

func send_to_cursor():
	pass

func get_as_json():
	var config = {
		"cursor_id": cursor_id,
		"size": size,
		"opacity": opacity,
		"color": color
	}
	return config

func set_from_json(config: Dictionary):
	cursor_id = config["cursor_id"]
	size = config["size"]
	opacity = config["opacity"]
	color = config["color"]

func get_as_message(instruction: String):
	return Message.new(instruction, get_as_json())
