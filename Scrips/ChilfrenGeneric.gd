extends CharacterBody2D

var dificulty = 1
var acompañanado =false
@onready var target 
@onready var game_ref

# Experimento
var player_position
var target_position

func set_direction():
	player_position = target.position
	target_position = (player_position - position).normalized()
	if position.distance_to(player_position) > 75:
		return target_position			
	else:
		return Vector2.ZERO


func follow_player(movement):
	velocity = movement
	move_and_slide()

func setDifficulty(cant):
	dificulty = cant

func get_direction():
	return target.getposition()

func capture_kid(t):
	acompañanado = true
	target = t
	#global_position = get_direction()		VER ESTO CON JUAN
	#target.addArray(self)

func lose_kid():
	game_ref.lose_life()
	if acompañanado:
		target.removeFromArray(self)
	queue_free()
