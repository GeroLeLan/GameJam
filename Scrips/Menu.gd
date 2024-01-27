extends Node2D
@onready var leaderboard_manager = preload("res://Scrips/leaderboard_manager.gd").new()

func _ready():
	leaderboard_manager.load_leaderboard_data() #inicializa el leaderboard si no existe

func _on_button_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_button_leaderboard_pressed():
	get_tree().change_scene_to_file("res://Scenes/leader_board.tscn")


func _on_button_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")
<<<<<<< HEAD


func _on_button_creditos_pressed():
=======
	
func _on_button_credits_pressed():
>>>>>>> bfd0a739888103fbd74e35a16b3a5a707f5bbd0f
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
