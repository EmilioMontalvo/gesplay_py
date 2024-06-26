extends Node2D

@onready var sprite:AnimatedSprite2D=$AnimatedSprite2D
@onready var audio:AudioStreamPlayer2D=$AudioStreamPlayer2D

@export var modulate_color: int=0

signal popped

func _ready():
	if modulate_color==1:
		modulate=Color(0,0,1)
	if modulate_color==2:
		modulate=Color(0,1,0)
	if modulate_color==3:
		modulate=Color(0,1,1)
		

func _on_area_2d_mouse_entered():
	popped.emit()
	sprite.play("pop")
	audio.play()
	$Area2D.queue_free()


func _on_animated_sprite_2d_animation_finished():
	queue_free()
