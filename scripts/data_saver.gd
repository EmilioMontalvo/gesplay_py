class_name DataSaver

const PATH_PROFILE: String = "user://profiles/"
const PATH_LAST_PROFILE: String = "user://last_profile/"
const PATH_LAST_PROFILE_FILE: String = "user://last_profile/last_profile_id.save"
const PATH_SETTINGS: String = "user://settings/"
const PATH_GAME_DATA_CURSOR: String = "user://game_data_cursor/"
const PATH_GAME_DATA_CLICK: String = "user://game_data_click/"

static func save_profile(profile_data: Dictionary):
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var profile_saver: FileAccess
	profile_saver = FileAccess.open(PATH_PROFILE + profile_data.get("id") + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify(profile_data)
	print("save_profile",json_string)
	profile_saver.store_line(json_string)

static func load_profiles() -> Array:
	var profiles: Array = []
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var profiles_dir = DirAccess.open(PATH_PROFILE)
	var profile_files = profiles_dir.get_files()
	for profile_path in profile_files:
		var profile_saver = FileAccess.open(PATH_PROFILE + profile_path, FileAccess.READ)
		var json_string = profile_saver.get_line()
		profiles.append(JSON.parse_string(json_string))
	
	print("load_profiles",profiles)
	return profiles

static func load_profile_by_id(id: String) -> Dictionary:
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var file_profile = FileAccess.open(PATH_PROFILE + id + ".save", FileAccess.READ)
	var json_string = file_profile.get_line()
	
	print("load_profile_by_id",json_string)
	return JSON.parse_string(json_string)

static func delete_profile(profile_id: String):
	return DirAccess.remove_absolute(PATH_PROFILE + profile_id + ".save")

static func save_last_profile_id(profile_id: String):
	DirAccess.make_dir_absolute(PATH_LAST_PROFILE)
	var file_last_profile: FileAccess
	file_last_profile = FileAccess.open(PATH_LAST_PROFILE_FILE, FileAccess.WRITE)
	file_last_profile.store_line(profile_id)

static func load_last_profile_id() -> String:
	DirAccess.make_dir_absolute(PATH_LAST_PROFILE)
	var file_path = PATH_LAST_PROFILE_FILE
	if FileAccess.file_exists(file_path):
		var file_profile = FileAccess.open(file_path, FileAccess.READ)
		return file_profile.get_line()
	else:
		return ""

static func delete_last_profile_file():
	return DirAccess.remove_absolute(PATH_LAST_PROFILE_FILE)

static func save_settings(settings: Dictionary, id: String):
	DirAccess.make_dir_absolute(PATH_SETTINGS)
	var settings_saved: Dictionary = {}
	var settings_saver: FileAccess
	var exists_settings = FileAccess.file_exists(PATH_SETTINGS + id + ".save")
	if exists_settings:
		settings_saved = load_settings_by_id(id)
		for key in settings.keys():
			settings_saved[key] = settings[key]
	settings_saver = FileAccess.open(PATH_SETTINGS + id + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify(settings_saved if exists_settings else settings)
	settings_saver.store_line(json_string)

static func load_settings_by_id(id: String) -> Dictionary:
	DirAccess.make_dir_absolute(PATH_SETTINGS)
	var file_settings = FileAccess.open(PATH_SETTINGS + id + ".save", FileAccess.READ)
	var json_string = file_settings.get_line()
	return JSON.parse_string(json_string)

# Game Data Cursor
static func save_game_data_cursor(game_data: Dictionary, id: String):
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CURSOR)
	var game_data_saver: FileAccess
	game_data_saver = FileAccess.open(PATH_GAME_DATA_CURSOR + id + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify(game_data)
	game_data_saver.store_line(json_string)

static func load_game_data_cursor_by_id(id: String) -> Dictionary:
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CURSOR)
	var file_game_data = FileAccess.open(PATH_GAME_DATA_CURSOR + id + ".save", FileAccess.READ)
	var json_string = file_game_data.get_line()
	return JSON.parse_string(json_string)

static func save_game_progress_cursor(game_data: Dictionary):
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CURSOR)
	var game_data_loaded = load_game_data_cursor_by_id(game_data.get("profile_id"))
	game_data_loaded["game_data"][game_data.get("level_id")].append(game_data)
	save_game_data_cursor(game_data_loaded, game_data.get("profile_id"))

# Game Data Click
static func save_game_data_click(game_data: Dictionary, id: String):
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CLICK)
	var game_data_saver: FileAccess
	game_data_saver = FileAccess.open(PATH_GAME_DATA_CLICK + id + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify(game_data)
	game_data_saver.store_line(json_string)

static func load_game_data_click_by_id(id: String) -> Dictionary:
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CLICK)
	var file_game_data = FileAccess.open(PATH_GAME_DATA_CLICK + id + ".save", FileAccess.READ)
	var json_string = file_game_data.get_line()
	return JSON.parse_string(json_string)

static func save_game_progress_click(game_data: Dictionary):
	DirAccess.make_dir_absolute(PATH_GAME_DATA_CLICK)
	var game_data_loaded = load_game_data_click_by_id(game_data.get("profile_id"))
	game_data_loaded["game_data"][game_data.get("level_id")].append(game_data)
	save_game_data_click(game_data_loaded, game_data.get("profile_id"))
