extends Node2D

@onready var shovel=$Shovel
@onready var destructionPoligon=$Shovel.get_destruction_polygon()
@onready var points=$CanvasLayer/Points
@onready var timer=$CanvasLayer/Time
@onready var helpArrow=$Guides/ShovelArrow

@onready var character_sprite=preload("res://assets/cursor_game/ducky_3_spritesheet.png")
@export var keys=1
@export var current_level:int=1

var shovel_point
var mistakes_count=0

@export var terrain_type="dirt"
var level_data: LevelData = LevelData.new()
signal won
# Called when the node enters the scene tree for the first time.
func _ready():
	shovel_point=shovel.global_position
	if terrain_type=="snow":
		var texture_snow=load("res://assets/cursor_game/textures/snow_texture.png")
		$Polygon2D.texture=texture_snow
		$HardTerrainContainer/HardTerrain/Polygon2D.texture=texture_snow
		var lines=$LinesContainer.get_children()
		
		for x in lines:
			x.texture=texture_snow
	helpArrow.set_target(shovel_point/scale-position)


func _on_shovel_touched(body):
	
	if body.is_in_group("destructible"):
		destroy_terrain(body)
	elif body.is_in_group("points"):
		get_points_from(body)
		shovel_point=body.global_position
	elif body.is_in_group("HardTerrain"):		
		shovel.out_of_terrain(shovel_point)
		points.sub_points(50)
		mistakes_count=mistakes_count+1
	elif body.is_in_group("objective"):
		get_points_from(body)
		shovel.drop_end()
		timer.stop()
		emit_signal("won")
	elif body.is_in_group("key"):
		grab_key(body)


func destroy_terrain(body):
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

func get_points_from(body):
	var pointNode=body.get_parent()
	points.add_points(pointNode.get_value())
	pointNode.explode()

func _on_shovel_has_been_grabbed():
	points.add_points(shovel.grab_points)
	

func get_points():
	return points.actualPoints

func get_time():
	return timer.get_time()

func grab_key(body):
	body.get_parent().explode()
	shovel_point=body.global_position
	keys=keys-1
	if keys<=0:
		$Jail.open()


func _on_shovel_grabbed_shovel():
	helpArrow.visible=false



func _on_shovel_dropped():
	helpArrow.set_target(shovel.global_position/scale-position)
	helpArrow.visible=true

func save_level_progress():
	level_data.profile_id = CurrentProfile.id
	level_data.level_id = str(current_level)
	level_data.mistake = mistakes_count
	level_data.elapsed_time = float(get_time_to_complete_level())
	level_data.score = points.get_points()
	level_data.stars = calculate_stars(points.get_points())
	level_data.completed = true
	level_data.date_time = Time.get_datetime_string_from_system()
	GameDataController.save_level_progress_cursor(level_data)

func get_time_to_complete_level():
	return $CanvasLayer/Time.get_time()

func calculate_stars(points):
	if points >= 600:
		return 3
	elif points >= 300:
		return 2
	else:
		return 1

func _on_won():
	save_level_progress()
