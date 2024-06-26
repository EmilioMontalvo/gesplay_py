extends Node

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var selected_song=0

var menu_music = preload("res://assets/click_game/sounds/music/level4.wav")
var cursor_duck_levels=preload("res://assets/cursor_game/audio/ChillingMonkey.wav")
var cursor_penguin_levels=preload("res://assets/cursor_game/audio/TeardropTempo.wav")


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

func change_song(song=0):
	if selected_song==song:
		return
	selected_song=song
	if song==0:
		audio_player.set_stream(menu_music)
		audio_player.play()
	elif song==1:
		audio_player.set_stream(cursor_duck_levels)
		audio_player.play()
	elif song==2:
		audio_player.set_stream(cursor_penguin_levels)
		audio_player.play()
	

