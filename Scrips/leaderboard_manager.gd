
extends Node
var json = JSON.new()

func load_leaderboard_data():
	var json_data = []
	if FileAccess.file_exists("user://leaderboard.json"):
		var file= FileAccess.open("user://leaderboard.json", FileAccess.READ)
		var error = json.parse(file.get_as_text())
		if error==OK:
			json_data = json.data
			if typeof(json_data) == TYPE_DICTIONARY:
				json_data = [json_data]
		file.close()
	return json_data

func save_leaderboard_data(leaderboard_data):
	var file = FileAccess.open("user://leaderboard.json", FileAccess.WRITE)
	var json_text = json.stringify(leaderboard_data, "\t", true, false)
	file.store_line(json_text)
	file.close()

func update_leaderboard(new_score, player_name):
	var leaderboard_data = load_leaderboard_data()
	leaderboard_data.append({"name": player_name, "score": new_score})
	leaderboard_data.sort_custom(compare_scores)
	leaderboard_data = leaderboard_data.slice(0, 9)
	save_leaderboard_data(leaderboard_data)

func compare_scores(entry1, entry2):
	return entry1["score"] > entry2["score"]
