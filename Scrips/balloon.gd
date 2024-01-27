extends Node2D

var travel_distance = 0

func _physics_process(delta):
	const SPEED = 300
	const RANGE = 600
	
	var direction = Vector2.UP
	position += direction * SPEED * delta
	travel_distance+= SPEED * delta 
	
	if travel_distance > RANGE:
		queue_free()
