extends Node

@onready var grid=$CanvasLayer/GridContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	SoundControllerMenu.change_song()
	SoundControllerMenu.continue_music()
	var first_level=$CanvasLayer/GridContainer.get_child(0)
	
	if first_level:
		first_level.get_child(0).grab_focus()
		first_level.get_child(0).focus_previous=NodePath("../../../HelpButton")
	
	if grid.lastUnlocked:
		$CanvasLayer/GoBack.focus_previous=NodePath(grid.lastUnlocked.get_child(0).get_path())
		
	
	



