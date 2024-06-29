class_name LevelData

var profile_id: String
var level_id: String
var mistake: int
var elapsed_time: float
var score: float
var stars: float
var completed: bool
var date_time: String

func get_json() -> Dictionary:
	return {
		"profile_id": profile_id,
		"level_id": level_id,
		"mistake": mistake,
		"elapsed_time": elapsed_time,
		"score": score,
		"stars": stars,
		"completed": completed,
		"date_time": date_time
	}
