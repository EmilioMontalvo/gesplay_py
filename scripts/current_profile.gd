extends Node

var is_profile_selected: bool = false
var id: String
var first_name: String
var last_name: String
var image_path: String

func set_data_from_dic(profile_data: Dictionary):
	id = profile_data.get("id")
	first_name = profile_data.get("first_name")
	last_name = profile_data.get("last_name")
	image_path = profile_data.get("image_path")
	
func get_profile_data() -> Dictionary:
	var profile_data: Dictionary
	profile_data["id"] = id
	profile_data["first_name"] = first_name
	profile_data["last_name"] = last_name
	profile_data["image_path"] = image_path
	return profile_data
