extends Control

func _ready():
	var profiles = DataSaver.load_profiles()
	for profile in profiles:
		var profile_button = preload("res://scenes/menu/components/profile_button.tscn").instantiate()
		profile_button.first_name = profile["first_name"]
		profile_button.last_name = profile["last_name"]
		profile_button.image_path = profile["image_path"]
		profile_button.profile_id = profile["id"]
		$ScrollContainer/ProfilesContainer.add_child(profile_button)
