extends Node2D

@onready var win_screen = $CanvasLayer/WinScreen


func _on_draggble_object_win():
	win_screen.visible = true
