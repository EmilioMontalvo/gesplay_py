extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_pressed():
	$"../Window".visible=true
	$"../Window"._ready()
	get_tree().root.mode = Window.MODE_MINIMIZED
