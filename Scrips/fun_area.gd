extends Node2D

@export var tipoArea = "red"
const CHAIN_MULTIPLIER = 1.5
@onready var game_ref = get_parent()


func calculate_score(player,chain):
	# chain es un array de pibitos
	var sum = 0
	var chain_size = chain.size()
	print("inicio suma")
	for i in range(chain.size()):
		var kid = chain.pop_front()
		sum += kid.score
		print(kid.score)
		player.array.erase(kid)
		kid.queue_free()		
	print(sum)
	var result = int(int(sum)**min(chain_size,5))	# 5 porque si
	print(result)
	return result



func _on_area_2d_body_entered(body):
	var chain_array
	if body.has_method("get_chain"):
		chain_array = body.get_chain()		
		var score = calculate_score(body,chain_array)
		game_ref.add_score(score)
	
	pass # Replace with function body.
