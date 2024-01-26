extends CharacterBody2D

var dificulty =1
var acompañanado =false
@onready var target = $"../Payaso"
@onready var game_ref

func follow_player(movement):
	velocity = movement
	move_and_slide()

func setDifficulty(cant):
	dificulty = cant

func get_direction():
	return target.getposition()

func capture_kid():
	acompañanado = true
	global_position = get_direction()
	target.addArray(self)

func lose_kid():
	game_ref.lose_life()
	if acompañanado:
		target.removeFromArray(self)
	queue_free()
