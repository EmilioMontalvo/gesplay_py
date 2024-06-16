extends GridContainer

@onready var level_scene=preload("res://scenes/menu/pages/cursor/elements/level_button.tscn")

@export var levelsArray=[
	[false,"Nivel 1",1,3],
	[true,"Nivel 2",2,2],
	[true,"Nivel 3",3,0],
	[true,"Nivel 4",4,0],
	[true,"Nivel 5",5,0],
	[true,"Nivel 6",6,0],
	[true,"Nivel 7",7,0],
	[true,"Nivel 8",8,0],
]
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in levelsArray:
		var instance=level_scene.instantiate()
		instance.locked=x[0]
		instance.level_name=x[1]
		instance.level=x[2]
		instance.stars=x[3]
		add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
