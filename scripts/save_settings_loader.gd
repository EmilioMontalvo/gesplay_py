extends Node

class_name SavedSettingsLoader

static func load_saved_settings():
	var setttings = DataSaver.load_settings_by_id(CurrentProfile.id)
	GlobalConf.set_from_json(setttings)
	ClickConf.set_from_json(setttings)
	CursorConf.set_from_json(setttings,true)
	CursorIconConf.set_from_json(setttings,true)
