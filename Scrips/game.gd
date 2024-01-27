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



@onready var kids_counter = 0 
const KIDS_LEVELUP_CAP = 5
@onready var fun_area = $FunAreas/FunArea
@onready var fun_area_2 = $FunAreas/FunArea2
@onready var fun_area_3 = $FunAreas/FunArea3

var dificultad_time = false


func _ready():
	$UI_Layer/Panel/TiempoLimite.start()
	var time = int($UI_Layer/Panel/TiempoLimite.time_left)
	$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = false
	#lives_label.text = "LIVES: "+str(lives)
	lives_label.text = "Time: "+str(time)
	score_label.text = "SCORE: "+str(global.score)

	# TODO - Agregar 3 pibes en cada zona al inicio
	$Payaso.set_arrow_target([fun_area.global_position, fun_area_2.global_position,fun_area_3.global_position])

func _process(delta):
	var time = int($UI_Layer/Panel/TiempoLimite.time_left)
	var minutos = time / 60
	var sec = time % 60
	if sec< 10:
		sec = "0" + str(sec)
	else:
		sec = str(sec)
	lives_label.text = "Time: "+str(minutos) + ":" + sec


func add_score(s):
	global.score += int(s)
	score_label.text = "SCORE: "+str(global.score)
	if dificultad_time == false:
		if kids_counter >= KIDS_LEVELUP_CAP:
			kids_counter = kids_counter % KIDS_LEVELUP_CAP
			update_difficulty()
	

func lose_life():
	lives -= 1
	lives_label.text = "LIVES: "+str(lives)
	
	if lives <= 0:
		# Pausar todos los timers
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")



func _physics_process(delta):
	pass



func update_difficulty():
	if(GlobalDificulty+DIFICULTY_INCRESER)<= MAX_DIFICULTY:
		GlobalDificulty+=DIFICULTY_INCRESER
		get_tree().call_group("children","setDifficulty",GlobalDificulty)
		$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = true
		$UI_Layer/Panel/LevelUpTimer.start()




func _on_level_up_timer_timeout():
	$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = false
	pass # Replace with function body.


func _on_tiempo_limite_timeout():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func modifyTime(value):
	var timer = $UI_Layer/Panel/TiempoLimite
	var time = int(timer.time_left + value)
	if(time>2):
		timer.stop()
		timer.set_wait_time(time)
		timer.start()
