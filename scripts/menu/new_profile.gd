extends Control

@onready var file_dialog: FileDialog = $FileDialog
 
func _on_file_upload_pressed():
	file_dialog.visible = true

func get_data_as_json() -> Dictionary:
	var new_profile_data: Dictionary = {
		"first_name": $TxtFirstName.text,
		"last_name": $TxtSecondName.text,
		"birthday": $XDateEdit.date.to_string(),
		"description": $TxtDescription.text,
		"photo_path": file_dialog.current_path
	}
	return new_profile_data 

func _on_acept_pressed():
	print(get_data_as_json())
