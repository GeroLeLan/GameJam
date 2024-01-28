extends Node2D

@export var final_score = 0
@onready var leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()

func _ready():
	$CanvasLayer/Panel/ScoreLabel.text = "SCORE: "+str(global.score)

func _on_quit_button_pressed():
	get_tree().quit()


func _on_button_pressed():
	global.score = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_submit_pressed():
	var nombre = $CanvasLayer/Panel/LineEdit.text
	leaderboard_manager.update_leaderboard(global.score,nombre)
	$CanvasLayer/Panel/Submit.disabled = true
	openleaderboard()
	
func openleaderboard():
	leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()
	var leaderboard_data = leaderboard_manager.load_leaderboard_data()
	var vboxName = $CanvasLayer/Panel/VBoxContainer
	var vboxScore = $CanvasLayer/Panel/VBoxContainer3
	for entry in leaderboard_data:
		
		var label_name : Label = Label.new()
		label_name.text = entry["name"]
		var label_score : Label = Label.new()
		label_score.text = str(entry["score"])
		label_name.set_custom_minimum_size(Vector2(100, label_score.get_minimum_size().y))
		label_score.set_custom_minimum_size(Vector2(50, label_score.get_minimum_size().y))
		
		vboxName.add_child(label_name)
		vboxScore.add_child(label_score)


func _on_button_2_pressed():
	global.score = 0
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
