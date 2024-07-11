extends Node

class_name ApiSettings
var http_load_settings: HTTPRequest
signal loaded
var loaded_settings=false

func _ready():
	http_load_settings=HTTPRequest.new()
	add_child(http_load_settings)
	http_load_settings.request_completed.connect(_on_settings_request_completed)

func _on_settings_request_completed(result, response_code, headers, body):
	
	if response_code==200:
		var setttings=JSON.parse_string(body.get_string_from_utf8())
		GlobalConf.set_from_json(setttings)
		ClickConf.set_from_json(setttings)
		CursorConf.set_from_json(setttings,true)
		CursorIconConf.set_from_json(setttings,true)
		loaded_settings=true
	loaded.emit(loaded_settings)

func load_saved_settings():
	var route=RequestManager.api_route+"/game-settings?profile_id_db="+CurrentProfile.id
	http_load_settings.request(route,RequestManager.get_auth_headers(),HTTPClient.METHOD_GET)

