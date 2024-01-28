extends Node2D

const MAX_DIFICULTY = 3.1
const DIFICULTY_INCRESER = 0.2
const SPAWN_TIMER_MAX = 5.0
const SCORE_LEVELUP_INITIAL = 100


@onready var lives_label = $UI_Layer/Panel/HBoxContainer/LivesLabel
@onready var score_label = $UI_Layer/Panel/HBoxContainer/ScoreLabel
@onready var zone_randomizer = $ZoneRandomizer


@onready var GlobalDificulty = 1
@onready var lives = 3
@onready var levelUp_counter = 1

@onready var kids_counter = 0 
@onready var score_counter = 0

@onready var fun_area = $FunAreas/FunArea
@onready var fun_area_2 = $FunAreas/FunArea2
@onready var fun_area_3 = $FunAreas/FunArea3

@onready var progressBar = $UI_Layer/ComboPanel/ProgressBar 
@onready var progress_bar_timer = $UI_Layer/ComboPanel/ProgressBar/ProgressBarTimer

# ComboPanel
var funAreaActive
var dificultad_time = false





func _ready():
	$UI_Layer/Panel/TiempoLimite.start()
	var time = int($UI_Layer/Panel/TiempoLimite.time_left)
	$UI_Layer/Panel/HBoxContainer/LevelUpLabel.visible = false
	#lives_label.text = "LIVES: "+str(lives)
	lives_label.text = "Time: "+str(time)
	score_label.text = "SCORE: "+str(global.score)
	# TODO - Agregar 3 pibes en cada zona al inicio
	selecZone()
	funAreaActive.disableToggle()
	updateComboPanel()
	$ZoneRandomizer.start()

func _process(delta):
	var time = int($UI_Layer/Panel/TiempoLimite.time_left)
	var minutos = time / 60
	var sec = time % 60
	if sec< 10:
		sec = "0" + str(sec)
	else:
		sec = str(sec)
	lives_label.text = "Time: "+str(minutos) + ":" + sec

func updateComboPanel():
	var comboIcon = $UI_Layer/ComboPanel/TextRect
	var comboBox = $UI_Layer/ComboPanel/HBoxContainer
	
	for node in comboBox.get_children():
		node.queue_free()
	
	var activeAreaType = funAreaActive.area_name
	if activeAreaType == "futbol":
		comboIcon.texture = preload("res://Sprites/fuchibol.png")
	elif activeAreaType == "arcade":
		comboIcon.texture = preload("res://Sprites/jueguitos.png")
	else:
		comboIcon.texture = preload("res://Sprites/comida.png")
	
	
	var activeChain = funAreaActive.target_chain
	for elem in activeChain:
		var textRect = TextureRect.new()
		if elem == 0:
			textRect.texture = preload("res://Sprites/pibita .png")
		elif elem == 1:
			textRect.texture = preload("res://Sprites/pibito 1.png")
		else:
			textRect.texture = preload("res://Sprites/pibito 3.png")
		#textRect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		textRect.expand_mode = 3
		comboBox.add_child(textRect)
	
		$Payaso.set_arrow_target(funAreaActive)

func add_score(s):
	global.score += int(s)
	score_label.text = "SCORE: "+str(global.score)
	
	
	if global.score >= SCORE_LEVELUP_INITIAL*levelUp_counter:
		update_difficulty()
	




func _physics_process(delta):
	pass



func update_difficulty():
	if(GlobalDificulty+DIFICULTY_INCRESER)<= MAX_DIFICULTY:
		levelUp_counter+=1
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
	else:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func SelectNewArea():
	funAreaActive.disableToggle()
	selecZone()
	updateComboPanel()
	funAreaActive.disableToggle()
	$ZoneRandomizer.stop()
	$ZoneRandomizer.start()
	$UI_Layer/ComboPanel/ProgressBar.value=0


func selecZone():
	var rng = RandomNumberGenerator.new()
	var my_random_number = int(rng.randf_range(1,3))
	if(my_random_number == 1 and funAreaActive == fun_area):
		funAreaActive = fun_area_2
	elif(my_random_number == 2 and funAreaActive == fun_area_2):
		funAreaActive = fun_area_3
	elif(my_random_number == 3 and funAreaActive == fun_area_3):
		funAreaActive = fun_area
	elif(my_random_number == 1):
		funAreaActive = fun_area
	elif(my_random_number == 2):
		funAreaActive = fun_area_2
	elif(my_random_number == 3):
		funAreaActive = fun_area_3



func _on_zone_randomizer_timeout():
	modifyTime(-30)
	SelectNewArea()
	


func _on_progress_bar_timer_timeout():
	progressBar.value=$ZoneRandomizer.time_left/$ZoneRandomizer.wait_time*100
	
