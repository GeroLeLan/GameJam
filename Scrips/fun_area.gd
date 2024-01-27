extends Node2D

@export var chain_size = 2
@export var base_score = 10
@export var chain_score = 100			# Definir luego por cada zona

var target_chain

@onready var game_ref = get_parent()
@onready var h_box_container = $Panel/HBoxContainer

func _ready():
	initialize_chain()
	


func initialize_chain():
	# Limpio todos los hijos del container
	for node in h_box_container.get_children():
		node.queue_free()
	
	# Genero una cadena al azar
	target_chain = []
	for i in range(chain_size):
		var element = randi() % 3
		target_chain.append(element)
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
	
	


func count_check(target_chain,current_chain):
	var count = 0

	for i in range(current_chain.size() - target_chain.size() + 1):
		var m = true
		for j in range(target_chain.size()):
			if current_chain[i + j] != target_chain[j]:
				m = false
				break
		if m:
			count += 1

	return count


func calculate_score(player,chain):
	var size = chain.size()
	var int_chain = []
	# Recorro array de pibitos y anoto la chain de ints
	for i in range(chain.size()):
		var kid = chain.pop_front()
		int_chain.append(kid.color)
		player.array.erase(kid)
		kid.queue_free()
	
	# Calculo la cantidad de veces que se verifica la cadena.
	var chain_count = count_check(target_chain,int_chain)
	var result = base_score*(size - chain_count*chain_size) + chain_count*chain_score
	
	
	return result



func _on_area_2d_body_entered(body):
	var chain_array
	if body.has_method("get_chain"):
		chain_array = body.get_chain()		
		var score = calculate_score(body,chain_array)
		game_ref.add_score(score)
		initialize_chain()
	
	pass # Replace with function body.
