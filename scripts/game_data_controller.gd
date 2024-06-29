extends Node
class_name GameDataControl

func save_initial_game_data(profile_id: String):
	var default_game_data_cursor = Constants.DEFAULT_GAME_DATA_CURSOR.duplicate()
	default_game_data_cursor["profile_id"] = profile_id
	var default_game_data_click = Constants.DEFAULT_GAME_DATA_CLICK.duplicate()
	default_game_data_click["profile_id"] = profile_id
	DataSaver.save_game_data_cursor(default_game_data_cursor, profile_id)
	DataSaver.save_game_data_click(default_game_data_click, profile_id)

func save_level_progress_cursor(level_data: LevelData):
	DataSaver.save_game_progress_cursor(level_data.get_json())

func save_level_progress_click(level_data: LevelData):
	DataSaver.save_game_progress_click(level_data.get_json())
