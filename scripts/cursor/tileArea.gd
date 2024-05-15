extends Node

var drawing=false
@onready var winscreen=$"../CanvasLayer/WinScreen"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_mouse_entered():
	drawing=true


func _on_mouse_exited():
	drawing=false
	winscreen.visible=true
