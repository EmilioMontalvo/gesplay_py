extends Control

@onready var button: Button = $Button
@onready var icon: Texture = load("res://assets/buttons/icons/lock.png")

var level: String
var is_locked: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if(is_locked):
		button.icon = icon
	else:
		button.text = level



func _on_press_change_to_level():
	if(!is_locked):
		CurrentClickLevel.level = int(level)
		get_tree().change_scene_to_file("res://scenes/menu/pages/click/levels/level_"+level+".tscn")
