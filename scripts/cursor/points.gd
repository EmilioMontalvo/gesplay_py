extends Node

@onready var pointsLabel = $Label
@export var actualPoints=0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label_value(actualPoints)


func add_points(points):
	actualPoints+=points
	set_label_value(actualPoints)

func sub_points(points):
	actualPoints-=points
	set_label_value(actualPoints)

func set_label_value(points):
	actualPoints=points
	pointsLabel.text=str(actualPoints)


