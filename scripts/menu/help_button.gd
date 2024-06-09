extends Node

signal help_request

func _ready():
	pass # Replace with function body.



func _on_pressed():
	help_request.emit()
