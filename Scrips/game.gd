extends Node2D

const MAX_DIFICULTY = 3.1
const DIFICULTY_INCRESER = 0.2
const SPAWN_TIMER_MAX = 5.0

@onready var lives_label = $UI_Layer/Panel/HBoxContainer/LivesLabel
@onready var score_label = $UI_Layer/Panel/HBoxContainer/ScoreLabel

@onready var spawn_timer = $SpawnTimer
@onready var kid_spawnner = $KidSpawnner
@onready var dificultTimer = $DifficultTimer
@onready var GlobalDificulty = 1
@onready var lives = 3


func _ready():
	spawn_timer.start()
	dificultTimer.start()
	$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = false
	lives_label.text = "LIVES: "+str(lives)
	score_label.text = "SCORE: "+str(global.score)
	spawn_timer.wait_time = SPAWN_TIMER_MAX
	for i in range(3):
		kid_spawnner.spawn_kid_insideView()

func add_score(s):
	global.score += int(s)
	score_label.text = "SCORE: "+str(global.score)

func lose_life():
	lives -= 1
	lives_label.text = "LIVES: "+str(lives)
	
	if lives <= 0:
		# Pausar todos los timers
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")



func _physics_process(delta):
	pass

func _on_spawn_timer_timeout():
	kid_spawnner.spawn_kid_insideView()
	spawn_timer.start()
	pass # Replace with function body.


func _on_difficult_timer_timeout():
	if(GlobalDificulty+DIFICULTY_INCRESER)<= MAX_DIFICULTY:
		GlobalDificulty+=DIFICULTY_INCRESER
		kid_spawnner.setDificulty(GlobalDificulty)
		get_tree().call_group("children","setDifficulty",GlobalDificulty)
		$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = true
		$UI_Layer/Panel/LevelUpTimer.start()
		spawn_timer.wait_time = SPAWN_TIMER_MAX - GlobalDificulty
		


func _on_level_up_timer_timeout():
	$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = false
	pass # Replace with function body.
