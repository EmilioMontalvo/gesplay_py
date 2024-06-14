extends Node2D

func _on_button_pressed():
	var last_profile_id: String = DataSaver.load_last_profile_id()
	print(last_profile_id)
	if last_profile_id.is_empty():
		if not CurrentProfile.is_profile_selected:
			MenuManager.load_menu(3)
	else:
		var last_profile = DataSaver.load_profile_by_id(last_profile_id)
		CurrentProfile.set_data_from_dic(last_profile)
		CurrentProfile.is_profile_selected = true
		MenuManager.load_menu(1)
