extends Control

func _ready():
	var profiles = DataSaver.load_profiles()
	for profile in profiles:
		var profile_button = preload("res://scenes/menu/components/profile_button.tscn").instantiate()
		profile_button.profile_data = profile
		$ScrollContainer/ProfilesContainer.add_child(profile_button)
