extends Control

@onready var star_points = $Panel/StarPoints
@onready var time_container = $Panel/TimeContainer
@onready var countdown_container = $Panel/CountdownContainer
@onready var label: Label = $Panel/Label

var final_points: float
var time_elapsed: String
var final_level: bool

func _ready():
	star_points.set_stars_image(final_points)
	set_time_container(time_elapsed)
	countdown_container.timeout_level.connect(_on_forward_button_pressed)
	if final_level:
		star_points.position.y = 171
		label.position.y = 125
		time_container.position.y = 330
		countdown_container.queue_free()
		$Panel/HBoxContainer/ForwardButton.queue_free()

func _on_forward_button_pressed():
	go_next_level()

func _on_repeat_button_pressed():
	get_tree().reload_current_scene()

func _on_home_button_pressed():
	SoundControllerMenu.continue_music()
	MenuManager.load_menu(MenuManager.MENU_LEVEL.CLICK_LEVELS)

func set_time_container(time: String):
	time_container.stop()
	time_container.set_time(time)

func go_next_level():
	var next_level = CurrentClickLevel.level + 1
	CurrentClickLevel.level = next_level
	MenuManager.change_to_file("res://scenes/menu/pages/click/levels/level_"+str(next_level)+".tscn")
