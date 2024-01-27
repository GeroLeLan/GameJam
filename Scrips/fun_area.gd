extends Node2D

@export var chain_size = 3
var chain
const CHAIN_MULTIPLIER = 1.5
@onready var game_ref = get_parent()
@onready var h_box_container = $Panel/HBoxContainer

func _ready():
	initialize_chain()
	


func initialize_chain():
	# Genero una cadena al azar
	chain = []
	for i in range(chain_size):
		var element = randi() % 3
		chain.append(element)
		var textRect = TextureRect.new()

		if element == 0:
			textRect.texture = preload("res://Sprites/slime_body.png")
		elif element == 1:
			textRect.texture = preload("res://Sprites/slime_body_hurt.png")
		else:
			textRect.texture = preload("res://Sprites/square_ref.png")
		#textRect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		textRect.expand_mode = 2
		h_box_container.add_child(textRect)
	
	print(chain)
	
	# Setup panel


func calculate_score(player,chain):
	# chain es un array de pibitos
	var sum = 0
	var chain_size = chain.size()
	for i in range(chain.size()):
		var kid = chain.pop_front()
		sum += kid.score
		player.array.erase(kid)
		kid.queue_free()		
	var result = int(int(sum)*min(chain_size,5))	# 5 porque si
	return result



func _on_area_2d_body_entered(body):
	var chain_array
	if body.has_method("get_chain"):
		chain_array = body.get_chain()		
		var score = calculate_score(body,chain_array)
		game_ref.add_score(score)
	
	pass # Replace with function body.
