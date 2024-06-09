extends Node2D

var success_count = 0
var success_to_win = 0
var mistakes_count = 0
var time_init
var actual_level: String

# Called when the node enters the scene tree for the first time.
func _ready():
	print("actual level: ",actual_level)
	MenuManager.set_current_scene(get_node("."))
	var dragabbles_list = get_tree().get_nodes_in_group('draggable')
	success_to_win = get_tree().get_nodes_in_group('dropable').size()
	for draggable in dragabbles_list:
		draggable.success.connect(_on_draggable_object_success)
		draggable.mistake.connect(_on_draggable_object_mistake)
	time_init = Time.get_unix_time_from_system()


func _on_draggable_object_success():
	increase_success()
	check_success()
	
func _on_draggable_object_mistake():
	increase_mistakes()
	
func increase_success():
	success_count += 1
	print("Succes count: ", success_count)

func check_success():
	if success_count >= success_to_win:
		show_win_screen()
		print('win')
		print('Time to complete level: ',get_time_to_complete_level())
		
func increase_mistakes():
	mistakes_count += 1
	print("Mistakes count: ", mistakes_count)
	
func get_time_to_complete_level():
	return Time.get_unix_time_from_system() - time_init

func show_win_screen():
	var win_screen = preload("res://scenes/menu/pages/click/win_screen_click_game.tscn").instantiate()
	win_screen.set_global_position(get_viewport_rect().size / 2)
	add_child(win_screen)
