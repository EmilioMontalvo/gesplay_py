extends Button

@onready var profile_image: TextureRect = $MarginContainer/HBoxContainer/ProfileImage
@onready var profile_name: Label = $MarginContainer/HBoxContainer/ProfileName

func _ready():
	if CurrentProfile.is_profile_selected:
		profile_name.text = CurrentProfile.first_name + " " + CurrentProfile.last_name
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
	$MarginContainer/HBoxContainer/ProfileImage.texture = texture
