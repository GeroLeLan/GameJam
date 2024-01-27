extends Node2D

@export var chain_size = 2
@export var base_score = 10
@export var chain_score = 100			# Definir luego por cada zona

var target_chain

@onready var game_ref = get_parent()
@onready var h_box_container = $Panel/HBoxContainer
@onready var confetti_shooter = $ConfettiShooter

func _ready():
	initialize_chain()



func emit_balloon(count):
	var values = [Color.AQUA, Color.RED, Color.BLUE_VIOLET, Color.GREEN, Color.YELLOW]
	for i in range(count):
		var balloon = preload("res://Scenes/balloon.tscn").instantiate()
		balloon.modulate = values[randi() % values.size()]
		$Path2D/PathFollow2D.progress_ratio = randf()
		balloon.global_position = $Path2D/PathFollow2D.global_position
		get_parent().add_child(balloon)

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
			textRect.texture = preload("res://Sprites/pibita .png")
		elif element == 1:
			textRect.texture = preload("res://Sprites/pibito 1.png")
		else:
			textRect.texture = preload("res://Sprites/pibito 3.png")
		#textRect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		textRect.expand_mode = 3
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
	game_ref.kids_counter+= chain.size()
	
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
	
	
	if chain_count > 0:
		emit_balloon(chain_count*3)
	
	if result > 0:
		confetti_shooter.emitting = true
		# VER: Podriamos hacer que a mas larga la cadena, mas confetti tira
		confetti_shooter.process_material = confetti_shooter.process_material.duplicate()
		confetti_shooter.restart()
	
	return result



func _on_area_2d_body_entered(body):
	var chain_array
	if body.has_method("get_chain"):
		chain_array = body.get_chain()		
		var score = calculate_score(body,chain_array)
		game_ref.add_score(score)
		initialize_chain()
		game_ref.modifyTime((chain_size-1)*10)
