extends Node2D

@onready var poligonTerrain=$Polygon2D
@export var type="dirt"
# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionPolygon2D.polygon=$Polygon2D.polygon
	$StaticBody2D/CollisionPolygon2D.global_position=$Polygon2D.global_position
	if type=="snow":
		change_texture("res://assets/cursor_game/textures/snow_texture_crack.png")
		pass

func get_poligon_to_destroy():
	return $Polygon2D

func set_new_terrain_poligon(new_poligon):
	$Polygon2D.set_deferred("polygon",new_poligon)
	$StaticBody2D/CollisionPolygon2D.set_deferred("polygon",new_poligon)

func change_texture(res):
	$Polygon2D.texture=load(res)
	
