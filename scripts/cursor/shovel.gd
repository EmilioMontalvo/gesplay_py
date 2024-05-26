extends Node2D


@onready var destructionPoligon=$Destruccion/CollisionPolygon2D
var grabbed = false
signal touched


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if grabbed:
		global_position=get_viewport().get_mouse_position()


func _on_collision_detection_area_entered(area:Area2D):
	print(area)


func _on_area_2d_mouse_entered():
	grabbed=true


func _on_collision_detection_body_entered(body):
	emit_signal("touched",body)
	
func get_destruction_polygon():
	return destructionPoligon

