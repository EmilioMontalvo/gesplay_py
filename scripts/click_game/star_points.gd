extends TextureRect

var star_images: Dictionary

func _ready():
	star_images = {
		"0": get_texture_from_file("res://assets/click_game/stars/star0.png"),
		"0.5": get_texture_from_file("res://assets/click_game/stars/star0.5.png"),
		"1": get_texture_from_file("res://assets/click_game/stars/star1.png"),
		"1.5": get_texture_from_file("res://assets/click_game/stars/star1.5.png"),
		"2": get_texture_from_file("res://assets/click_game/stars/star2.png"),
		"2.5": get_texture_from_file("res://assets/click_game/stars/star2.5.png"),
		"3": get_texture_from_file("res://assets/click_game/stars/star3.png")
	}

func get_texture_from_file(path: String) -> ImageTexture:
	return ImageTexture.create_from_image(Image.load_from_file(path))

func set_stars_image(points: float):
	if fmod(points,0.75) == 0 and fmod(points,0.5) != 0:
		points += 0.25
	print("points: ",points)
	texture = star_images.get(str(points))
