extends Node

class_name CustomCursor

var cursor_id = 3
var size = 100
var opacity = 0.5
var color = Color(0.3098,0.639,0.866,1)
var active = true

func new_size(new_size: Vector2):
	size = new_size

func set_opacity(new_opacity: float):
	opacity = new_opacity

func set_color(new_color: Color):
	color = new_color

func get_as_array():
	return [cursor_id, size, opacity, color]


func get_as_json():
	var config = {
		"cursor_id": cursor_id,
		"size": size,
		"opacity": opacity,
		"color": color,
		"active":active
	}
	return config

func set_from_json(config: Dictionary, send_to_udp=false):
	cursor_id = config["cursor_id"]
	size = config["size"]
	opacity = config["opacity"]
	color = config["color"]
	active=config["active"]
	
	if send_to_udp:
		send_update_to_upd()

func get_as_message(instruction: String):
	return Message.new(instruction, get_as_json())

func send_update_to_upd():
	UdPServer.send_message(get_as_message("update_cursor_icon_config"))

func save_config():
	var json_to_save=get_as_json()
	json_to_save["color"]=[color[0],color[1],color[2],color[3]]
	DataSaver.save_settings(json_to_save,CurrentProfile.id)
