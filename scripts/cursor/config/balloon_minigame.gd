extends Node2D

var balloon_scene = preload("res://scenes/menu/components/cursor/balloon.tscn")
@export var spawn_interval: float = 0.8
@export var max_balloons: int = 4

# Internal variables
var balloon_count: int = 0

func _ready():
	# Start the timer
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.connect("timeout", _on_Timer_timeout)
	add_child(timer)
	timer.start()
	
	# Initial balloon creation
	for i in range(max_balloons):
		create_balloon()

func _on_Timer_timeout():
	if balloon_count < max_balloons:
		create_balloon()

func create_balloon():
	var view_port_size=get_viewport().size
	var balloon_instance = balloon_scene.instantiate()
	
	# Set a random position for the balloon
	var random_x = randi_range(30, view_port_size.x-30)
	var random_y = randi_range(30, view_port_size.y-30)
	# Avoid the bottom-left corner
	if random_x < view_port_size.x * 0.5 and random_y > view_port_size.y * 0.5:
		random_x = randi_range(view_port_size.x * 0.5, view_port_size.x)
		random_y = randi_range(0, view_port_size.y * 0.5)
	
	balloon_instance.global_position = Vector2(random_x, random_y)
	
	
	# Connect the 'popped' signal to the '_on_balloon_popped' method
	balloon_instance.connect("popped",_on_balloon_popped)
	
	# Add the balloon instance to the scene
	add_child(balloon_instance)
	
	balloon_count += 1

func _on_balloon_popped():
	balloon_count -= 1
	$CanvasLayer/TextureRect/Control.add_one()


