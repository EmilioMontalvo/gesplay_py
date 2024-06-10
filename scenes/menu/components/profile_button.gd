extends Control

var first_name: String
var last_name: String
var image_path: String

func _ready():
	$ProfileButton/ProfileName.text = first_name + " " + last_name
	var profile_image = Image.load_from_file(image_path)
	var texture_image = ImageTexture.create_from_image(profile_image)
	$ProfileButton/TextureProfile.texture = texture_image
