extends Node2D

@onready var leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()

func _ready():
	var leaderboard_data = leaderboard_manager.load_leaderboard_data()
	var vbox = $VBoxContainer
	
	for entry in leaderboard_data:
		var hbox : HBoxContainer = HBoxContainer.new()
		
		var label_name : Label = Label.new()
		label_name.text = entry["name"]
		var label_score : Label = Label.new()
		label_score.text = str(entry["score"])
		label_name.set_custom_minimum_size(Vector2(100, label_score.get_minimum_size().y))
		label_score.set_custom_minimum_size(Vector2(50, label_score.get_minimum_size().y))
		hbox.add_child(label_name)
		hbox.add_child(label_score)
		vbox.add_child(hbox)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
