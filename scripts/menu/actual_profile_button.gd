extends Button

@onready var container: HBoxContainer = $HBoxContainer

func _ready():
	if CurrentProfile.is_profile_selected:
		$HBoxContainer/Label.text = CurrentProfile.first_name + " " + CurrentProfile.last_name
		set_profile_image(CurrentProfile.image_path)
		#var x_size = container.size
		#print(x_size)
		#size.x = x_size

func _on_pressed():
	MenuManager.load_menu(3)
	
func set_profile_image(path: String):
	var profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(profile_image)
	texture.set_size_override(Vector2i(48,48))
	$HBoxContainer/TextureRect.texture = texture
