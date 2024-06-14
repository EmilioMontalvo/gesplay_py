extends Node


func _on_pressed():
	get_parent().get_parent().get_parent().reload_current_scene()
