extends Node2D

var balloon_scene = preload("res://scenes/menu/components/cursor/balloon.tscn")

func _ready():
	create_balloon()

func create_balloon():
	var balloon_instance = balloon_scene.instantiate()
	
	# Set a random position for the balloon
	var random_x = randi_range(0, get_viewport().size.x)
	var random_y = randi_range(0, get_viewport().size.y)
	balloon_instance.position = Vector2(random_x, random_y)
	
	# Connect the 'popped' signal to the '_on_balloon_popped' method
	balloon_instance.connect("popped",_on_balloon_popped)
	
	# Add the balloon instance to the scene
	add_child(balloon_instance)

func _on_balloon_popped():
	$CanvasLayer/Control.add_one()


