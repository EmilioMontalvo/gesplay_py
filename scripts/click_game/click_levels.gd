extends Control

@onready var box_container_top: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer
@onready var box_container_bottom: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer2
@onready var go_back: TextureButton = $Header/GoBack
@onready var home: TextureButton = $Header/Home
@onready var help_button = $Header/HelpButton

var max_level: int

func _ready():
	max_level = CurrentProfile.max_click_level
	var level_selector = preload("res://scenes/menu/pages/click/level_selector.tscn")
	for i in range(1,7):
		if(i < 4):
			box_container_top.add_child(get_level_selector(i,level_selector.instantiate()))
		else:
			box_container_bottom.add_child(get_level_selector(i,level_selector.instantiate()))
	var first_level = box_container_top.get_child(0).button
	first_level.grab_focus()
	box_container_bottom.get_child(2).button.focus_next = NodePath(go_back.get_path())
	help_button.focus_next = NodePath(first_level.get_path())

func get_level_selector(level,level_selector):
	level_selector.is_locked = !(level <= max_level)
	level_selector.level = str(level)
	return level_selector
