extends Node2D

var successCount = 0
var successToWin = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var dragabblesList = get_tree().get_nodes_in_group('draggable')
	successToWin = dragabblesList.size()
	for draggable in dragabblesList:
		draggable.success.connect(_on_draggable_object_success)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_draggable_object_success():
	increase_success()
	check_success()
	
func increase_success():
	successCount += 1
	print(successCount)

func check_success():
	if successCount >= successToWin:
		print('win')
