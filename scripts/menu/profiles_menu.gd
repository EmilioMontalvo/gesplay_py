extends Control

@onready var profile_container: VBoxContainer =  $ScrollContainer/ProfilesContainer

func _ready():
	$HBoxContainer/SearchBar.grab_focus()
	check_profile_selected()
	fill_profiles_container()

func _process(delta):
	check_profile_selected()

func check_profile_selected():
	if not CurrentProfile.is_profile_selected:
		$SelectProfileAlert.visible = true
		$Home.visible = false
		$GoBack.visible = false

func fill_profiles_container():
	clear_profile_container()
	var profiles = DataSaver.load_profiles()
	var num_profiles = profiles.size()
	if num_profiles == 0:
		CurrentProfile.is_first_profile = true
		MenuManager.load_menu(2)
	for profile in profiles:
		var profile_button = preload("res://scenes/menu/components/profile_button.tscn").instantiate()
		profile_button.profile_data = profile
		profile_button.profile_deleted.connect(_on_profile_deleted)
		if num_profiles == 1:
			profile_button.can_delete = false
		profile_container.add_child(profile_button)

func clear_profile_container():
	var profiles = profile_container.get_children()
	if profiles.size() == 0:
		return
	for profile in profiles:
		profile_container.remove_child(profile)

func _on_profile_deleted():
	fill_profiles_container()
