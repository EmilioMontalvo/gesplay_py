extends Node

@export var scene:int = 0

func _on_pressed():
	MenuManager.load_menu(scene)


func _on_acept_pressed():
	pass # Replace with function body.
