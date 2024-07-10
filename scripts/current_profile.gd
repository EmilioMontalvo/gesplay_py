extends Node

var is_profile_selected: bool = false
var is_first_profile: bool = false

var id: String
var first_name: String
var last_name: String
var image_path: String
var max_click_level: int
var max_cursor_level: int
var http_request_profile: HTTPRequest

func _ready():
	http_request_profile = HTTPRequest.new()
	add_child(http_request_profile)
	http_request_profile.request_completed.connect(_on_request_profile_completed)

func set_data_from_dic(profile_data: Dictionary):
	id = profile_data.get("id")
	first_name = profile_data.get("first_name")
	last_name = profile_data.get("last_name")
	image_path = profile_data.get("image_path")
	max_click_level = profile_data.get("max_click_level")
	max_cursor_level = profile_data.get("max_cursor_level")
	save_actual_profile()
	
func get_profile_data() -> Dictionary:
	var profile_data: Dictionary = {}
	profile_data["id"] = id
	profile_data["first_name"] = first_name
	profile_data["last_name"] = last_name
	profile_data["image_path"] = image_path
	profile_data["max_click_level"] = max_click_level
	profile_data["max_cursor_level"] = max_cursor_level
	return profile_data

func save_actual_profile():
	if GlobalConf.invite_mode:
		DataSaver.save_last_profile_id(id)
	else:
		ApiDataSaver.save_last_profile_id(id)
	
func save_profile_progress():
	if GlobalConf.invite_mode:
		DataSaver.save_profile(get_profile_data())
	else:
		ApiDataSaver.save_profile(get_profile_data())

func delete_last_profile():
	if GlobalConf.invite_mode:
		DataSaver.delete_last_profile_file()

func reload_data():
	if GlobalConf.invite_mode:
		set_data_from_dic(DataSaver.load_profile_by_id(id))
	else:
		http_request_profile.request(
			RequestManager.get_endpoint_path(ApiDataSaver.LAST_PROFILE_ENDPOINT),
			RequestManager.get_auth_headers(),
			HTTPClient.METHOD_GET
		)
		await http_request_profile.request_completed

func _on_request_profile_completed(result, response_code, headers, body):
	set_data_from_dic(JSON.parse_string(body.get_string_from_utf8()))
