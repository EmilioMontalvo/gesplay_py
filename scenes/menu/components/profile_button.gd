extends Control

@onready var profile_data: Dictionary
@onready var delete_button: Button = $Delete

var can_delete: bool = true

signal profile_deleted

func _ready():
	if not can_delete:
		delete_button.disabled = true
	$ProfileButton/ProfileName.text = profile_data.get("first_name") + " " + profile_data.get("last_name")
	var profile_image = Image.load_from_file(profile_data.get("image_path"))
	var texture_image = ImageTexture.create_from_image(profile_image)
	$ProfileButton/TextureProfile.texture = texture_image

func _on_delete_pressed():
	var profile_id = profile_data.get("id")
	var success = DataSaver.delete_profile(profile_id)
	if success == OK:
		if profile_id == CurrentProfile.id:
			CurrentProfile.is_profile_selected = false
			CurrentProfile.delete_last_profile()
		profile_deleted.emit()
		queue_free()

func _on_edit_pressed():
	var new_profile_instance = preload("res://scenes/menu/pages/new_profile2.tscn").instantiate()
	new_profile_instance.profile_data = profile_data
	new_profile_instance.is_editing = true
	
	MenuManager.load_instace_menu(new_profile_instance)

func _on_profile_button_pressed():
	CurrentProfile.set_data_from_dic(profile_data)
	CurrentProfile.is_profile_selected = true
	MenuManager.load_menu(1)
