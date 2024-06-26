extends Node

class_name CursorLevel

@onready var win_screen=$CanvasLayer/WinScreen
@export var next_level=2
@export var last=false
@export var song=1
# Called when the node enters the scene tree for the first time.
func _ready():
	win_screen.next_level=next_level
	win_screen.last=last
	$CanvasLayer/LevelHeader.scene_home
	$CanvasLayer/LevelHeader.set_current_level(next_level-1)
	SoundControllerMenu.change_song(song)
	SoundControllerMenu.continue_music()

func _on_level_container_won():
	win_screen.visible=true
	win_screen.set_points($level_container.get_points())
	win_screen.set_time($level_container.get_time())
