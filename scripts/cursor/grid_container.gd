extends GridContainer

@onready var level_scene=preload("res://scenes/menu/pages/cursor/elements/level_button.tscn")
@export var unlocked_levels=0
@export var levelsArray=[
	[true,"Nivel 1",1,0],
	[true,"Nivel 2",2,0],
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
		instance.locked=unlocked_levels<0
		instance.level_name=x[1]
		instance.level=x[2]
		instance.stars=x[3]
		add_child(instance)
		unlocked_levels=-1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
