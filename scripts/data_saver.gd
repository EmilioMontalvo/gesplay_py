class_name DataSaver

const PATH_PROFILE: String = "user://profiles/"
const PATH_LAST_PROFILE: String = "user://last_profile/"
const PATH_LAST_PROFILE_FILE: String = "user://last_profile/last_profile_id.save"

static func save_profile(profile_data: Dictionary):
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var profile_saver: FileAccess
	profile_saver = FileAccess.open(PATH_PROFILE + profile_data.get("id") + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify(profile_data)
	profile_saver.store_line(json_string)

static func load_profiles() -> Array:
	var profiles: Array = []
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var profiles_dir = DirAccess.open(PATH_PROFILE)
	var profile_files = profiles_dir.get_files()
	for profile_path in profile_files:
		var profile_saver = FileAccess.open(PATH_PROFILE+profile_path,FileAccess.READ)
		var json_string = profile_saver.get_line()
		profiles.append(JSON.parse_string(json_string))
		
	return profiles

static func load_profile_by_id(id: String) -> Dictionary:
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var file_profile = FileAccess.open(PATH_PROFILE + id + ".save",FileAccess.READ)
	var json_string = file_profile.get_line()
	return JSON.parse_string(json_string)

static func delete_profile(profile_id: String):
	return DirAccess.remove_absolute(PATH_PROFILE+profile_id+".save")

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
