extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_poligon_to_destroy():
	return $Polygon2D

func set_new_terrain_poligon(new_poligon):
	$Polygon2D.set_deferred("polygon",new_poligon)
	$StaticBody2D/CollisionPolygon2D.set_deferred("polygon",new_poligon)
