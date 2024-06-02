extends Control

@onready var window_mode_option: OptionButton = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer2/WindowMode

func _ready():
	pass

func _on_acept_pressed():
	var window_mode_id = window_mode_option.get_selected_id()
	if(window_mode_id == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if(window_mode_id == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
