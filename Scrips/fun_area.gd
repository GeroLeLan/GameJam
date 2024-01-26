extends Node2D

@export var tipoArea = "red"
const CHAIN_MULTIPLIER = 1.5
@onready var game_ref = get_parent()
func calculate_score(chain):
	# chain es un array de ints [97, 76, 21]
	
	var sum = 0
	for element in chain:
		sum+= element
		
	var result = int(sum*CHAIN_MULTIPLIER)
	return  result



func _on_area_2d_body_entered(body):
	var chain_array
	if body.has_method("get_chain"):
		chain_array = body.get_chain()		# Parametrizar el tipo si hacemos opcion2
		var score = calculate_score(chain_array)
		game_ref.add_score(score)
	
	pass # Replace with function body.
