extends Control

@onready var lbl_profile_name:Label = $HBoxContainer/CurrentProfile/ProfileName
@onready var profile_image_texture: TextureRect = $HBoxContainer/CurrentProfile/ProfileImage

var current_profile_data: Dictionary

func _ready():
	current_profile_data = CurrentProfile.get_profile_data()
	lbl_profile_name.text = current_profile_data.get("first_name") + " " + current_profile_data.get("last_name")
	set_profile_image(current_profile_data.get("image_path"))
	
func set_profile_image(path: String):
	var profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(profile_image)
	texture.set_size_override(Vector2i(300,300))
	profile_image_texture.texture = texture


func _on_btn_edit_profile_pressed():
	var new_profile_instance = preload("res://scenes/menu/pages/new_profile2.tscn").instantiate()
	new_profile_instance.profile_data = current_profile_data
	new_profile_instance.is_editing = true
	var root_scene = get_tree().root.get_node("/root/SceneContainer")
	for children in root_scene.get_children():
		root_scene.remove_child(children)
	root_scene.add_child(new_profile_instance)
