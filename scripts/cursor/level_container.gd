extends Node2D

@onready var destructionPoligon=$Shovel.get_destruction_polygon()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shovel_touched(body):
	if body.is_in_group("destructible"):
		var terrain = body.get_parent()
		var target: Node2D = terrain.get_poligon_to_destroy()
		
		var offset_poligon = Polygon2D.new()
		offset_poligon.polygon = target.global_transform * target.polygon
		
		var offset_destruction = Polygon2D.new()
		offset_destruction.polygon = destructionPoligon.global_transform * destructionPoligon.polygon
		var resultsArray=Geometry2D.clip_polygons(offset_poligon.polygon, offset_destruction.polygon)
		
		if resultsArray.size()!=0:
			var result: Array = resultsArray[0]
			var result_poligon = Polygon2D.new()
			result_poligon.polygon = result
			# Transformar el polígono resultante de vuelta a las coordenadas locales del terreno
			var inverse_transform = target.global_transform.affine_inverse()
			result_poligon.polygon = inverse_transform * result_poligon.polygon
			terrain.set_new_terrain_poligon(result_poligon.polygon)
		else:
			terrain.set_new_terrain_poligon(resultsArray)
