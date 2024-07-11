extends Node

class_name SavedSettingsLoader

static func load_saved_settings():
	
	if GlobalConf.invite_mode:
		var setttings = DataSaver.load_settings_by_id(CurrentProfile.id)
		GlobalConf.set_from_json(setttings)
		ClickConf.set_from_json(setttings)
		CursorConf.set_from_json(setttings,true)
		CursorIconConf.set_from_json(setttings,true)
		return true
	else:
		var settingsNode=ApiSettings.new()
		GlobalConf.add_child(settingsNode)
		settingsNode.load_saved_settings()
		await settingsNode.loaded
		return settingsNode.loaded_settings


