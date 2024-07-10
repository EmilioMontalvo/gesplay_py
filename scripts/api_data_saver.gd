class_name ApiDataSaver

const PROFILES_ENDPOINT: String = "/profiles/me"
const LAST_PROFILE_ENDPOINT: String = "/profiles/last"
const DELETE_PROFILE_ENDPOINT: String = "/profiles"
const SETTINGS_ENDPOINT: String = "/game-settings"
const GAME_DATA_ENDPOINT: String = "/profiles/{profile_id_db}/game-data/{game}"
const LEVEL_ENDPOINT: String = "/profiles/{profile_id_db}/game-data/{game}/level/{level}"
const PROFILE_IMAGE_ENDPOINT: String = "/profiles/me/{profile_id_db}/image"
const SET_IMAGE_ENDPOINT: String = "/profiles/me/{profile_id_db}/image"


static func save_profile(profile_data: Dictionary):
	var endpoint = PROFILES_ENDPOINT
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, profile_data)

static func save_profile_progress(profile_data: Dictionary):
	var endpoint = PROFILES_ENDPOINT + "/" + profile_data.get("id")
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_PUT, profile_data)

static func edit_profile(profile_data: Dictionary):
	var endpoint = PROFILES_ENDPOINT + "/" + profile_data.get("id")
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_PUT, profile_data)
	
static func save_image_profile(image_profile: Image, profile_id: String):
	var endpoint = PROFILE_IMAGE_ENDPOINT.format({"profile_id_db": profile_id})
	var body: PackedByteArray
	body.append_array("--BodyBoundaryHere".to_utf8_buffer())
	body.append_array("\r\nContent-Disposition: form-data; name=\"file\"; filename=\"Treasure.png\"\r\n".to_utf8_buffer())
	body.append_array("Content-Type: image/png\r\n".to_utf8_buffer())
	body.append_array("Content-Transfer-Encoding: base64\r\n".to_utf8_buffer())
	body.append_array("\r\n".to_utf8_buffer())
	body.append_array(Marshalls.raw_to_base64(image_profile.save_png_to_buffer()).to_utf8_buffer())
	body.append_array("\r\n".to_utf8_buffer())
	body.append_array("--BodyBoundaryHere".to_utf8_buffer())
	var headers: PackedStringArray = [
		RequestManager.get_auth_headers()[0],
		"Content-Length: " + str(body.size()),
		"Content-Type: multipart/form-data; boundary=\"BodyBoundaryHere\""
	]
	RequestManager.make_request(endpoint, headers, HTTPClient.METHOD_PUT, body)

#func load_profiles() -> Array:
#	var endpoint = PROFILES_ENDPOINT
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

#func load_profile_by_id(id: String) -> Dictionary:
#	var endpoint = PROFILES_ENDPOINT + "/" + id
#	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func delete_profile(profile_id: String):
	var endpoint = DELETE_PROFILE_ENDPOINT + "/" + profile_id
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_DELETE)

static func save_last_profile_id(profile_id: String):
	var endpoint = LAST_PROFILE_ENDPOINT + "?profile_id=" + profile_id
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_PUT)

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
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, JSON.stringify(game_data))

# Game Data Click
static func save_game_data_click(game_data: Dictionary, profile_id_db: String, game: String="click"):
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, game_data)

static func load_game_data_click_by_id(profile_id_db: String, game: String="click") -> Dictionary:
	var endpoint = GAME_DATA_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game})
	return RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

static func save_game_progress_click(game_data: Dictionary, profile_id_db: String, level: String,game: String="click"):
	var endpoint = LEVEL_ENDPOINT.format({"profile_id_db": profile_id_db, "game": game, "level": level})
	RequestManager.make_request(endpoint, RequestManager.get_auth_headers(), HTTPClient.METHOD_POST, JSON.stringify(game_data))

static func update_profile_image(profile_id_db: String,file_path:String):
	var endpoint = SET_IMAGE_ENDPOINT.format({"profile_id_db": profile_id_db})
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:		
		var image_data = file.get_buffer(file.get_length())
		file.close()
		
		var body = PackedByteArray()
		body.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L\r\n".to_utf8_buffer())
		body.append_array("Content-Disposition: form-data; name=\"file\"; filename=\"icon.png\"\r\n".to_utf8_buffer())
		body.append_array("Content-Type: image/png\r\n\r\n".to_utf8_buffer())
		body.append_array(image_data)
		body.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L--\r\n".to_utf8_buffer())
		
		var headers = [
			 RequestManager.get_auth_headers()[0],
			"Content-Type: multipart/form-data;boundary=\"WebKitFormBoundaryePkpFF7tjBAqx29L\""
		]
		
		RequestManager.make_request_raw(endpoint,headers,HTTPClient.METHOD_PUT,body)

