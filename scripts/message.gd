extends Object

class_name Message

var instruction : String
var content : Dictionary

# Constructor
func _init(instruction_arg: String, content_arg: Dictionary):
	instruction = instruction_arg
	content = content_arg

# Método para convertir el mensaje a JSON
func to_json():
	var message_dict = {
		"instruction": instruction,
		"content": content
	}
	return message_dict

func _to_string():
	return JSON.stringify(to_json())
