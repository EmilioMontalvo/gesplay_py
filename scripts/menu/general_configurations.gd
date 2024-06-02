extends Control

@onready var window_mode_option: OptionButton = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/WindowMode

func _ready():
	if get_current_display_mode() == 0 or get_current_display_mode() == 2:
		window_mode_option.selected = 0
	elif get_current_display_mode() == 3:
		window_mode_option.selected = 1

func _on_acept_pressed():
	var window_mode_id = window_mode_option.get_selected_id()
	if(window_mode_id == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if(window_mode_id == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func get_current_display_mode() -> int:
	return DisplayServer.window_get_mode(DisplayServer.window_get_current_screen())
