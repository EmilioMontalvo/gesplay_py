extends Node2D

@onready var star_points = $CanvasLayer/StarPoints
@onready var time_container = $CanvasLayer/TimeContainer
@onready var level_header = $CanvasLayer/LevelHeader
@onready var sound_controller = $SoundControllerClick

var max_level = 6
var success_count = 0
var success_to_win = 0
var mistakes_count = 0
var final_points: float = 0
var points_by_food: float
var points_by_animal: float
var time_init
var actual_level: String

# Called when the node enters the scene tree for the first time.
func _ready():
	print("actual level: ",actual_level)
	MenuManager.set_current_scene(get_node("."))
	init_dragabble_objects()
	set_points()
	time_init = Time.get_unix_time_from_system()
	level_header.set_current_level(CurrentClickLevel.level)
	sound_controller.play_music(CurrentClickLevel.level)

func init_dragabble_objects():
	var dragabbles_list = get_tree().get_nodes_in_group('draggable')
	success_to_win = get_tree().get_nodes_in_group('dropable').size()
	for draggable in dragabbles_list:
		draggable.success.connect(_on_draggable_object_success)
		draggable.mistake.connect(_on_draggable_object_mistake)
		draggable.food_point.connect(_on_draggable_object_food)

func set_points():
	var points: float = 3.0 / (success_to_win * 2.0)
	print("points by: ",points)
	points_by_food = points
	points_by_animal = points

func _on_draggable_object_food():
	increase_food_point()
	sound_controller.play_fx(SoundClickSources.sounds_fx.POINT)

func _on_draggable_object_success():
	increase_success()
	increase_animal_point()
	check_success()
	
func _on_draggable_object_mistake():
	increase_mistakes()
	sound_controller.play_fx(SoundClickSources.sounds_fx.MISTAKE)
	
func increase_food_point():
	final_points += points_by_food
	set_star_points()
	
func increase_animal_point():
	final_points += points_by_animal 
	set_star_points()
	
func increase_success():
	success_count += 1
	print("Succes count: ", success_count)

func check_success():
	if success_count >= success_to_win:
		if CurrentProfile.max_click_level < max_level:
			CurrentProfile.max_click_level = CurrentClickLevel.level + 1
		stop_timer()
		sound_controller.play_fx(SoundClickSources.sounds_fx.LEVEL_COMPLETE)
		save_progress()
		show_win_screen()
	else:
		sound_controller.play_fx(SoundClickSources.sounds_fx.SUCESS)
		
func increase_mistakes():
	mistakes_count += 1
	print("Mistakes count: ", mistakes_count)
	
func get_time_to_complete_level():
	return time_container.get_time()

func show_win_screen():
	var win_screen = preload("res://scenes/menu/pages/click/win_screen_click_game.tscn").instantiate()
	win_screen.final_points = final_points
	win_screen.time_elapsed = get_time_to_complete_level()
	win_screen.final_level = CurrentClickLevel.level == max_level
	win_screen.set_global_position(get_viewport_rect().size / 2)
	add_child(win_screen)
	
func save_progress():
	CurrentProfile.save_profile_progress()
	
func set_star_points():
	star_points.set_stars_image(final_points)
	
func stop_timer():
	time_container.stop()
