extends Node2D

var balloon_scene = preload("res://scenes/menu/components/cursor/balloon.tscn")
@export var spawn_interval: float = 1.0
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
	var balloon_instance = balloon_scene.instantiate()
	
	# Set a random position for the balloon
	var random_x = randi_range(0, get_viewport().size.x-30)
	var random_y = randi_range(0, get_viewport().size.y-30)
	balloon_instance.position = Vector2(random_x, random_y)
	
	# Connect the 'popped' signal to the '_on_balloon_popped' method
	balloon_instance.connect("popped",_on_balloon_popped)
	
	# Add the balloon instance to the scene
	add_child(balloon_instance)
	
	balloon_count += 1

func _on_balloon_popped():
	balloon_count -= 1
	$CanvasLayer/Control.add_one()


