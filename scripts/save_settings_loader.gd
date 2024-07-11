extends Node

class_name SavedSettingsLoader

static func load_saved_settings():
	
	if GlobalConf.invite_mode:
		var setttings = DataSaver.load_settings_by_id(CurrentProfile.id)
		GlobalConf.set_from_json(setttings)
		ClickConf.set_from_json(setttings)
		CursorConf.set_from_json(setttings,true)
		CursorIconConf.set_from_json(setttings,true)
	else:
		var request=HTTPRequest.new()
		request.request_completed.connect(_on_game_settings_request_completed)
		GlobalConf.add_child(request)
		var route=RequestManager.api_route+"/game-settings?profile_id_db="+CurrentProfile.id
		request.request(route,RequestManager.get_auth_headers(),HTTPClient.METHOD_GET)

static func _on_game_settings_request_completed(result, response_code, headers, body):
	if response_code==200:
		var setttings=JSON.parse_string(body.get_string_from_utf8())
		GlobalConf.set_from_json(setttings)
		ClickConf.set_from_json(setttings)
		CursorConf.set_from_json(setttings,true)
		CursorIconConf.set_from_json(setttings,true)
