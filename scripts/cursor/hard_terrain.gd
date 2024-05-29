extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionPolygon2D.polygon=$Polygon2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
