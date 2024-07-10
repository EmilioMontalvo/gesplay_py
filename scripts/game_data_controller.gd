extends Node
class_name GameDataControl

var request_save_level_progress: HTTPRequest

func _ready():
	if not GlobalConf.invite_mode:
		request_save_level_progress = HTTPRequest.new()
		add_child(request_save_level_progress)

func save_initial_game_data(profile_id: String):
	var default_game_data_cursor = Constants.DEFAULT_GAME_DATA_CURSOR.duplicate()
	default_game_data_cursor["profile_id"] = profile_id
	var default_game_data_click = Constants.DEFAULT_GAME_DATA_CLICK.duplicate()
	default_game_data_click["profile_id"] = profile_id
	DataSaver.save_game_data_cursor(default_game_data_cursor, profile_id)
	DataSaver.save_game_data_click(default_game_data_click, profile_id)

func save_level_progress_cursor(level_data: LevelData):
	if GlobalConf.invite_mode:
		DataSaver.save_game_progress_cursor(level_data.get_json())
	else:
		var enpoint_url = RequestManager.get_endpoint_path(ApiDataSaver.LEVEL_ENDPOINT.format({
			"profile_id_db": level_data.profile_id,
			"game": "cursor",
			"level": level_data.level_id
			}))
		request_save_level_progress.request(
			enpoint_url,
			RequestManager.get_auth_headers(),
			HTTPClient.METHOD_POST,
			JSON.stringify(level_data.get_json())
		)

func save_level_progress_click(level_data: LevelData):
	if GlobalConf.invite_mode:
		DataSaver.save_game_progress_click(level_data.get_json())
	else:
		var enpoint_url = RequestManager.get_endpoint_path(ApiDataSaver.LEVEL_ENDPOINT.format({
			"profile_id_db": level_data.profile_id,
			"game": "click",
			"level": level_data.level_id
			}))
		request_save_level_progress.request(
			enpoint_url,
			RequestManager.get_auth_headers(),
			HTTPClient.METHOD_POST,
			JSON.stringify(level_data.get_json())
		)
