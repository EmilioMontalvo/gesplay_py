extends Node

@onready var win_screen=$CanvasLayer/WinScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_container_won():
	win_screen.visible=true
	win_screen.set_points(0)
	win_screen.set_time(0)
