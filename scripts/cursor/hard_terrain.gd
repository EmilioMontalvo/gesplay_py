extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionPolygon2D.polygon=$Polygon2D.polygon


