extends Node

@onready var pointsLabel = $Label
@export var actualPoints=0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label_value(actualPoints)


func add_points(points):
	actualPoints+=points
	if actualPoints>=650:
		actualPoints=650
	set_label_value(actualPoints)

func sub_points(points):
	actualPoints-=points
	if actualPoints<0:
		actualPoints=0
	set_label_value(actualPoints)

func set_label_value(points):
	actualPoints=points
	pointsLabel.text=str(actualPoints)

func get_points():
	return actualPoints


