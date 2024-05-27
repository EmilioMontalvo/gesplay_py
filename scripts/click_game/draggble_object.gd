extends Node2D

@export var icon: Texture
@export var type: String

@onready var sprite: Sprite2D = $Sprite2D

var draggable = false
var is_inside_dropable = false
var body_ref
var body_ref_temp
var offset: Vector2
var initial_pos: Vector2

signal success
signal mistake

func _ready():
	sprite.texture = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initial_pos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalClick.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			GlobalClick.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position",initial_pos,0.2).set_ease(Tween.EASE_OUT)
			check_types()

func check_types():
	if body_ref_temp != null:
		if body_ref_temp.get_type() == type:
			success.emit()
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"global_position",initial_pos,1.0).set_ease(Tween.EASE_OUT)
			mistake.emit()

func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color('#F6EEDE',1)
		body_ref = body
		body_ref_temp = body
		'''
		if body.get_type() == type:
			win.emit()
		else:
			lose.emit()
		'''

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body_ref_temp = null
		#body.modulate = Color('#F6EEDE',0.7)
		body.modulate = Color('#000000',1.0)
		


func _on_area_2d_mouse_entered():
	if not GlobalClick.is_dragging:
		draggable = true
		scale = Vector2(1.35,1.35)

func _on_area_2d_mouse_exited():
	if not GlobalClick.is_dragging:
		draggable = false
		scale = Vector2(1.25,1.25)
