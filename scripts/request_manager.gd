extends Node

var http_request: HTTPRequest
var api_route="http://localhost:8000"
var api_is_up=false
# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed_health)	
	make_request("/healthcheck",[],HTTPClient.METHOD_GET)

func _on_request_completed_health(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	print(response)
	if response["status"]=="ok":
		api_is_up=true
	

func make_request(endpoint: String, 
custom_headers: PackedStringArray = PackedStringArray(), 
method: HTTPClient.Method = 0, body={}):
	
	var body_string = JSON.new().stringify(body)
	var route=api_route+endpoint
	var error = http_request.request(route, [], method, body_string)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
