extends Node

@export var value=0

func _ready():
	set_value(value)

func add_one():
	value=value+1
	set_value(value)

func set_value(new_value):
	value=new_value
	$Label.text=str(value)
