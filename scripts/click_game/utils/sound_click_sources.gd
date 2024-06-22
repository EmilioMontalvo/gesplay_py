extends Node

class_name SoundClickSources

enum sounds_fx {
	SUCESS,
	POINT,
	MISTAKE,
	LEVEL_COMPLETE
}

const FX_SOURCE = [
	preload("res://assets/click_game/sounds/FX/success.wav"),
	preload("res://assets/click_game/sounds/FX/point.wav"),
	preload("res://assets/click_game/sounds/FX/mistake.wav"),
	preload("res://assets/click_game/sounds/FX/level_complete.wav")
]

const MUSIC_SOURCE = [
	preload("res://assets/click_game/sounds/music/level1.wav"),
	preload("res://assets/click_game/sounds/music/level2.wav"),
	preload("res://assets/click_game/sounds/music/level3.wav"),
	preload("res://assets/click_game/sounds/music/level4.wav"),
	preload("res://assets/click_game/sounds/music/level5.wav"),
	preload("res://assets/click_game/sounds/music/level6.wav")
]

static func get_fx_source(index: int):
	return FX_SOURCE[index]
	
static func get_music_source(index: int):
	return MUSIC_SOURCE[index]
