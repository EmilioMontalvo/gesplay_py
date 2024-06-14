extends Control

func _ready():
	if not CurrentProfile.is_profile_selected:
		MenuManager.load_menu(3)
