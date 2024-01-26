extends Node2D

@export var final_score = 0

func _ready():
	$CanvasLayer/Panel/ScoreLabel.text = "SCORE: "+str(final_score)



func _on_quit_button_pressed():
	get_tree().quit()

