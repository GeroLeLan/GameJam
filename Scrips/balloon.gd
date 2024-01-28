extends Node2D

var travel_distance = 0

func _ready():
	setColor(randi_range(0,2))


func setColor(color):
	if color == 0:
		$Sprite2D.play("balloon_blue")
	if color == 1: 
		$Sprite2D.play("balloon_green")
	if color == 2:
		$Sprite2D.play("balloon_red")



func _physics_process(delta):
	const SPEED = 300
	const RANGE = 600
	
	var direction = Vector2.UP
	position += direction * SPEED * delta
	travel_distance+= SPEED * delta 
	
	if travel_distance > RANGE:
		queue_free()
