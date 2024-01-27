extends Node2D

@export var final_score = 0
@onready var leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()

func _ready():
	$CanvasLayer/Panel/ScoreLabel.text = "SCORE: "+str(global.score)



func _on_quit_button_pressed():
	leaderboard_manager.update_leaderboard(global.score,"BOB")
	get_tree().quit()



func _on_button_pressed():
	leaderboard_manager.update_leaderboard(global.score,"BOB")
	global.score = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.
