extends Node

@onready var win_screen=$CanvasLayer/WinScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_level_container_won():
	win_screen.visible=true
	win_screen.set_points($level_container.get_points())
	win_screen.set_time($level_container.get_time())
