extends Node2D

@onready var audioPlayer=$AudioStreamPlayer2D
@onready var pellet_texture:Sprite2D=$Sprite2D

@export var value=50
@export var type="dirt"

# Called when the node enters the scene tree for the first time.
func _ready():
	if type=="snow":
		modulate=Color(0.9,0.5,0)



func get_value():
	return value

func explode():
	audioPlayer.play()	
	$Sprite2D.visible=false
	$StaticBody2D.queue_free()


func _on_audio_stream_player_2d_finished():
	queue_free()
