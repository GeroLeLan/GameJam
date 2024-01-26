extends Node2D

const MAX_DIFICULTY = 3.1
const DIFICULTY_INCRESER = 0.2

@onready var spawn_timer = $SpawnTimer
@onready var kid_spawnner = $KidSpawnner
@onready var dificultTimer = $DifficultTimer
@onready var GlobalDificulty = 1

func _ready():
	spawn_timer.start()
	dificultTimer.start()


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
