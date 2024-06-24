extends Control

class_name LevelButton

@export var locked=true
@export var level_name="Nivel 1"
@export var level=1
@export var stars=0
@export var texturePath="res://assets/cursor_game/levels/icons/level_1.png"

@onready var label:Label=$button/Text
@onready var button:TextureButton=$button
var levels=[
	preload("res://scenes/menu/pages/cursor/cursor_levels.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_1.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_2.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_3.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_4.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_5.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_6.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_7.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_8.tscn"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$locked.visible=locked
	label.text=level_name
	$stars.set_stars(stars)
	change_texture(texturePath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	MenuManager.load_packed_scene(levels[level])

func change_texture(res):
	button.texture_normal=load(res)
