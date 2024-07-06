class_name ApiDataSaver

const PROFILES_ENDPOINT: String = "/profiles/me"
const LAST_PROFILE_ENDPOINT: String = "/profiles/last"
const SETTINGS_ENDPOINT: String = "/game-settings"
const GAME_DATA_ENDPOINT: String = "/profiles/{profile_id_db}/game-data/{game}"
const LEVEL_ENDPOINT: String = "/profiles/{profile_id_db}/game-data/{game}/level/{level}"



static func save_profile(profile_data: Dictionary):
	var endpoint = PROFILES_ENDPOINT
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, profile_data)

#func load_profiles() -> Array:
#	var endpoint = PROFILES_ENDPOINT
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

#func load_profile_by_id(id: String) -> Dictionary:
#	var endpoint = PROFILES_ENDPOINT + "/" + id
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func delete_profile(profile_id: String):
	var endpoint = PROFILES_ENDPOINT + "/" + profile_id
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_DELETE)

#func save_last_profile_id(profile_id: String):
#	var endpoint = LAST_PROFILE_ENDPOINT
#	var data = {"profile_id": profile_id}
#	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, data)

#func load_last_profile_id() -> String:
#	var endpoint = LAST_PROFILE_ENDPOINT
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func delete_last_profile_file():
	var endpoint = LAST_PROFILE_ENDPOINT
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_DELETE)

static func save_settings(settings: Dictionary, id: String):
	var endpoint = SETTINGS_ENDPOINT + "/" + id
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, settings)

#func load_settings_by_id(id: String) -> Dictionary:
#	var endpoint = SETTINGS_ENDPOINT + "/" + id
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

# Game Data Cursor
static func save_game_data_cursor(game_data: Dictionary, profile_id_db: String, game: String="cursor"):
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, game_data)

static func load_game_data_cursor_by_id(profile_id_db: String, game: String="cursor") -> Dictionary:
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func save_game_progress_cursor(game_data: Dictionary, profile_id_db: String, level: String,game: String="cursor"):
	var endpoint = LEVEL_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game, "level": level})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, game_data)

# Game Data Click
static func save_game_data_click(game_data: Dictionary, profile_id_db: String, game: String="click"):
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, game_data)

static func load_game_data_click_by_id(profile_id_db: String, game: String="click") -> Dictionary:
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func save_game_progress_click(game_data: Dictionary, profile_id_db: String, level: String,game: String="click"):
	var endpoint = LEVEL_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game, "level": level})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, game_data)
