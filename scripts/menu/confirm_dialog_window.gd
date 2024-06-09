extends Window

signal canceled
signal acepted

@export var dialogText="Gestplay se cerrará"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/ConfirmationDialog.set_dialog_text(dialogText)


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_confirmation_dialog_option_selected(option):
	if option:
		acepted.emit()
	else:
		canceled.emit()
