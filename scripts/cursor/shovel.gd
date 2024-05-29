extends Node2D

class_name Shovel

@onready var audioPlayer=$AudioStreamPlayer2D
@onready var destructionPoligon=$Destruccion/CollisionPolygon2D
@onready var animation=$AnimationPlayer
@onready var grab_timer = Timer.new()

@export var grab_points=50
@export var dig_points=50

var can_destroy=true
var grabbed = false
var firstTime=true
signal touched
signal has_been_grabbed

func _ready():
	add_child(grab_timer)
	grab_timer.wait_time = 3.0
	grab_timer.one_shot = true
	#TODO: get audio from global config
	audioPlayer.volume_db=0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if grabbed:
		global_position=get_viewport().get_mouse_position()


func _on_collision_detection_area_entered(area:Area2D):
	print(area)


func _on_area_2d_mouse_entered():
	grabbed=true
	if firstTime:
		emit_signal("has_been_grabbed")
		audioPlayer.play()
		animation.stop()
		firstTime=false


func _on_collision_detection_body_entered(body):
	emit_signal("touched",body)

func get_destruction_polygon():
	return destructionPoligon

func drop_end():
	grabbed=false
	$GrabeDetection.queue_free()

func out_of_terrain():
	can_destroy=false
	$Sprite2D.modulate = Color(0, 0, 1) # blue shade

