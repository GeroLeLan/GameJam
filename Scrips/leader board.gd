extends Node2D

@onready var leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()

func _ready():
	var leaderboard_data = leaderboard_manager.load_leaderboard_data()
	var vboxName = $Panel/VBoxContainer2
	var vboxScore = $Panel/VBoxContainer
	for entry in leaderboard_data:
		
		
		var label_name : Label = Label.new()
		label_name.text = entry["name"]
		var label_score : Label = Label.new()
		label_score.text = str(entry["score"])
		label_name.set_custom_minimum_size(Vector2(100, label_score.get_minimum_size().y))
		label_score.set_custom_minimum_size(Vector2(50, label_score.get_minimum_size().y))
		
		vboxName.add_child(label_name)
		vboxScore.add_child(label_score)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
