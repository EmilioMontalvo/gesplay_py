extends Control

@onready var profile_container: VBoxContainer = $ScrollContainer/ProfilesContainer

var http_request: HTTPRequest

func _ready():
	$HBoxContainer/SearchBar.grab_focus()
	check_profile_selected()
	if GlobalConf.invite_mode:
		fill_profiles_container_local()
	else:
		http_request = HTTPRequest.new()
		if RequestManager.api_is_up:
			add_child(http_request)
			http_request.request_completed.connect(_on_request_completed)
			http_request.request(RequestManager.get_endpoint_path(ApiDataSaver.PROFILES_ENDPOINT), RequestManager.get_auth_headers(), HTTPClient.METHOD_GET)

func _process(delta):
	check_profile_selected()

func check_profile_selected():
	if not CurrentProfile.is_profile_selected:
		$SelectProfileAlert.visible = true
		$Home.visible = false
		$GoBack.visible = false

func fill_profiles_container_local():
	clear_profile_container()
	var profiles = DataSaver.load_profiles()
	var num_profiles = profiles.size()
	if num_profiles == 0:
		CurrentProfile.is_first_profile = true
		MenuManager.load_menu(2)
	for profile in profiles:
		var profile_button = preload ("res://scenes/menu/components/profile_button.tscn").instantiate()
		profile_button.profile_data = profile
		profile_button.profile_deleted.connect(_on_profile_deleted)
		if num_profiles == 1:
			profile_button.can_delete = false
		profile_container.add_child(profile_button)

func fill_profiles_container_api(response):
	clear_profile_container()
	var profiles: Array = response
	var num_profiles = profiles.size()
	if num_profiles == 0:
		CurrentProfile.is_first_profile = true
		MenuManager.load_menu(2)
	for profile in profiles:
		var profile_button = preload ("res://scenes/menu/components/profile_button.tscn").instantiate()
		profile["id"] = str(profile.get("id"))
		profile_button.profile_data = profile
		profile_button.profile_deleted.connect(_on_profile_deleted)
		if num_profiles == 1:
			profile_button.can_delete = false
		profile_container.add_child(profile_button)
	print(response)

func clear_profile_container():
	var profiles = profile_container.get_children()
	if profiles.size() == 0:
		return
	for profile in profiles:
		profile_container.remove_child(profile)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		fill_profiles_container_api(JSON.parse_string(body.get_string_from_utf8()))
	else:
		fill_profiles_container_local()

func _on_profile_deleted():
	fill_profiles_container_local()
