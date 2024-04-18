extends Node


var json=JSON.new()
var path="res://.WebcamMouse/profiles"

var data={}

func add_profile(name:String):
	var dir=DirAccess.open(path)
	dir.make_dir(name)

func write_content(content,fileName,profileName):
	var filepath=path+"/"+profileName+"/"+fileName
	var file=FileAccess.open(filepath,FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file=null
	
func add_default_profile():
	add_profile("default")
	#add default cursor config
	write_content(CursorConf.get_as_json(),"cursor.json","default")
	#TODO:add default click config

func load_config(profileName):
	load_cursor_config(profileName)
	#TODO:load deafult click config

func load_cursor_config(profileName):
	var filepath=path+"/"+profileName+"/"+"cursor.json"
	var file=FileAccess.open(filepath,FileAccess.READ)
	var content=json.parse_string(file.get_as_text())
	CursorConf.set_from_json(content)



