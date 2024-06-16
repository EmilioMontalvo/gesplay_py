extends Control

@export var locked=true
@export var level_name="Nivel 1"
@export var level=1

@onready var label:Label=$button/Text
var levels=[
	preload("res://scenes/menu/pages/cursor/cursor_levels.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_1.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$locked.visible=locked
	label.text=level_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	MenuManager.load_packed_scene(levels[level])
