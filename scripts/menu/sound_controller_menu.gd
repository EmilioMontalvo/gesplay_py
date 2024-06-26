extends Node

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var menu_music = preload("res://assets/click_game/sounds/music/level4.wav")

func _ready():
	audio_player.finished.connect(_on_music_finished)

func play_music():
	audio_player.play()
	
func pause_music():
	audio_player.stream_paused = true
	
func continue_music():
	audio_player.stream_paused = false
	
func _on_music_finished():
	audio_player.play()

	
