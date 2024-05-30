extends Control

@onready var box_container_top: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer
@onready var box_container_bottom: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer2
var max_level = 2

func _ready():
	var level_selector = preload("res://scenes/menu/pages/click/level_selector.tscn")
	for i in range(1,7):
		if(i < 4):
			box_container_top.add_child(get_level_selector(i,level_selector.instantiate()))
		else:
			box_container_bottom.add_child(get_level_selector(i,level_selector.instantiate()))

func get_level_selector(level,level_selector):
	level_selector.is_locked = !(level <= max_level)
	level_selector.level = str(level)
	return level_selector
