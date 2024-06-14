extends Node

var is_profile_selected: bool = false
var is_first_profile: bool = false

var id: String
var first_name: String
var last_name: String
var image_path: String
var max_click_level: int
var max_cursor_level: int

func set_data_from_dic(profile_data: Dictionary):
	id = profile_data.get("id")
	first_name = profile_data.get("first_name")
	last_name = profile_data.get("last_name")
	image_path = profile_data.get("image_path")
	max_click_level = profile_data.get("max_click_level")
	max_cursor_level = profile_data.get("max_cursor_level")
	
func get_profile_data() -> Dictionary:
	var profile_data: Dictionary = {}
	profile_data["id"] = id
	profile_data["first_name"] = first_name
	profile_data["last_name"] = last_name
	profile_data["image_path"] = image_path
	profile_data["max_click_level"] = max_click_level
	profile_data["max_cursor_level"] = max_cursor_level
	return profile_data
