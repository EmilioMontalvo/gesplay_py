extends Node2D

@onready var audioPlayer=$AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func explode():
	audioPlayer.play()	
	$Sprite2D.visible=false
	$StaticBody2D.queue_free()


func _on_audio_stream_player_2d_finished():
	queue_free()
