extends Control

@export var level: String

@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_press_change_to_level():
	get_tree().change_scene_to_file("res://scenes/menu/pages/click/levels/level_"+level+".tscn")
	
