extends Control

@onready var window_mode_option: OptionButton = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/WindowMode

func _ready():
	if get_current_display_mode() == 0 or get_current_display_mode() == 2:
		window_mode_option.selected = 0
	elif get_current_display_mode() == 3:
		window_mode_option.selected = 1
	$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/WindowMode.grab_focus()

func _on_acept_pressed():
	var window_mode_id = window_mode_option.get_selected_id()
	if(window_mode_id == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if(window_mode_id == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	save_configs()
	MenuManager.load_menu(MenuManager.MENU_LEVEL.SETTINGS)

func get_current_display_mode() -> int:
	return DisplayServer.window_get_mode(DisplayServer.window_get_current_screen())

func save_configs():
	GlobalConf.window_mode = window_mode_option.get_selected_id()
	GlobalConf.general_sound = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	GlobalConf.music = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	GlobalConf.sfx = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	GlobalConf.save_configs()

func _on_cancel_pressed():
	cancel_set_settings()
	MenuManager.load_menu(MenuManager.MENU_LEVEL.SETTINGS)

func cancel_set_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(GlobalConf.general_sound))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(GlobalConf.music))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(GlobalConf.sfx))
