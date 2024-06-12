class_name DataSaver

const PATH_PROFILE: String = "user://profiles/"

static func save_profile(profile_data: Dictionary):
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var save_profile: FileAccess
	if profile_data.has("id"):
		save_profile = FileAccess.open(PATH_PROFILE + profile_data.get("id") + ".save", FileAccess.WRITE)
	else:
		var new_profile_id = MinosUUIDGenerator.generate_new_UUID()
		save_profile = FileAccess.open(PATH_PROFILE + new_profile_id + ".save", FileAccess.WRITE)
		profile_data["id"] = new_profile_id
	var json_string = JSON.stringify(profile_data)
	save_profile.store_line(json_string)

static func load_profiles() -> Array:
	var profiles: Array = []
	var json_object = JSON.new()
	DirAccess.make_dir_absolute(PATH_PROFILE)
	var profiles_dir = DirAccess.open(PATH_PROFILE)
	var profile_files = profiles_dir.get_files()
	for profile_path in profile_files:
		var save_profile = FileAccess.open(PATH_PROFILE+profile_path,FileAccess.READ)
		var json_string = save_profile.get_line()
		profiles.append(json_object.parse_string(json_string))
		
	return profiles

static func delete_profile(profile_id: String):
	return DirAccess.remove_absolute(PATH_PROFILE+profile_id+".save")
	
