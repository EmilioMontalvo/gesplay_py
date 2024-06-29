extends Control

@export var scene:int = 1
@export var locked=false

func _on_pressed():
	if not locked:
		MenuManager.load_menu(scene)


func _on_acept_pressed():
	pass # Replace with function body.


func _on_focus_entered():
	modulate=Color(0.5,0.5,0.5,0.5)


func _on_focus_exited():
	modulate=Color(1,1,1,1)
