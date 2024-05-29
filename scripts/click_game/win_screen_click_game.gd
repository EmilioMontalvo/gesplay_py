extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_forward_button_pressed():
	var next_level = CurrentClickLevel.level + 1
	CurrentClickLevel.level = next_level
	get_tree().change_scene_to_file("res://scenes/menu/pages/click/levels/level_"+str(next_level)+".tscn")

func _on_repeat_button_pressed():
	get_tree().reload_current_scene()

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/pages/click/click_levels.tscn")
