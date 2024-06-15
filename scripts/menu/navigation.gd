extends Node

@export var scene:int = 1
@export var locked=false

func _on_pressed():
	if not locked:
		MenuManager.load_menu(scene)


func _on_acept_pressed():
	pass # Replace with function body.
