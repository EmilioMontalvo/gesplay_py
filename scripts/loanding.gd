extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var container=preload("res://scenes/menu/scene_container.tscn")	
	call_deferred("_deferred_change", container)


	
func _deferred_change(scene):
	get_tree().change_scene_to_packed(scene)
