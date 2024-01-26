extends Node2D

@export var final_score = 0

func _ready():
	$CanvasLayer/Panel/ScoreLabel.text = "SCORE: "+str(global.score)



func _on_quit_button_pressed():
	get_tree().quit()



func _on_button_pressed():
	global.score = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.
