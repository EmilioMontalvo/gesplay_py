extends Control

@onready var star_points = $Panel/StarPoints
@onready var time_container = $Panel/TimeContainer

var final_points: float
var time_elapsed: String

func _ready():
	star_points.set_stars_image(final_points)
	set_time_container(time_elapsed)

func _on_forward_button_pressed():
	var next_level = CurrentClickLevel.level + 1
	CurrentClickLevel.level = next_level
	get_tree().change_scene_to_file("res://scenes/menu/pages/click/levels/level_"+str(next_level)+".tscn")

func _on_repeat_button_pressed():
	get_tree().reload_current_scene()

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/pages/click/click_levels.tscn")

func set_time_container(time: String):
	time_container.stop()
	time_container.set_time(time)
