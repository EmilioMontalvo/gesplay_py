extends Node

@onready var FX: AudioStreamPlayer2D = $FX
@onready var Music: AudioStreamPlayer2D = $Music

func play_fx(index: int):
	FX.stream = SoundClickSources.get_fx_source(index)
	FX.play()

func play_music(level: int):
	Music.stream = SoundClickSources.get_music_source(level - 1)
	var auduio = AudioStream.new()
	Music.play()
	Music.finished.connect(_on_music_finished)

func _on_music_finished():
	Music.play()
