extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionPolygon2D.polygon=$Polygon2D.polygon
	$StaticBody2D/CollisionPolygon2D.global_position=$Polygon2D.global_position
	
	print($StaticBody2D/CollisionPolygon2D.global_position,$Polygon2D.global_position)


