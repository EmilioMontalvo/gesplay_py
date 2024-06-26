extends Node2D

@onready var sprite:AnimatedSprite2D=$AnimatedSprite2D
@onready var audio:AudioStreamPlayer2D=$AudioStreamPlayer2D

signal popped

func _on_area_2d_mouse_entered():
	popped.emit()
	sprite.play("pop")
	audio.play()
	$Area2D.queue_free()


func _on_animated_sprite_2d_animation_finished():
	queue_free()
