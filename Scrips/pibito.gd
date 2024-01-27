extends "res://Scrips/ChilfrenGeneric.gd"
signal kid_removed

@export var speed = 100
@onready var progress_bar = $ProgressBar
@onready var score
@onready var color
@onready var collision_shape_2d = $CollisionShape2D


const MAX_SCORE = 100.0
const SADNESS_DEPLETE_RATE = 5

func set_collision(b):
	collision_shape_2d.set_deferred("disabled",true)

func _ready():
	game_ref = get_parent()
	color = randi() % 3
	score = MAX_SCORE
	
	if velocity == Vector2.ZERO:
		velocity = Vector2.RIGHT.rotated(randf_range(0,TAU)) * speed * dificulty

func _physics_process(delta):
	setColor()
	if score <= 0.0:
		lose_kid()
	else:
			if acompañanado:
				score -= 0.7*SADNESS_DEPLETE_RATE*delta*dificulty
				progress_bar.value = score
			else:
				score -= SADNESS_DEPLETE_RATE*delta*dificulty
				progress_bar.value = score
	
	if(!acompañanado):
		var collision = move_and_collide(velocity*delta)
		
		if collision: 
			var bounce_velocity = velocity.bounce(collision.get_normal())
			velocity = bounce_velocity
	else:
		velocity = set_direction()*280
		move_and_slide()

func setColor():
	if color == 0:
		$AnimatedSprite2D.play("idle")
	if color ==1: 
		$AnimatedSprite2D.play("idle naranja")
	if color ==2:
		$AnimatedSprite2D.play("idle square")

