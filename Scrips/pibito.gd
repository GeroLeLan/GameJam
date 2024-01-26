extends "res://Scrips/ChilfrenGeneric.gd"
signal kid_removed

@export var speed = 100
@onready var progress_bar = $ProgressBar
@onready var score


const MAX_SCORE = 100.0
const SADNESS_DEPLETE_RATE = 5


func _ready():
	game_ref = get_parent()
	score = MAX_SCORE
	if velocity == Vector2.ZERO:
		velocity = Vector2.RIGHT.rotated(randf_range(0,TAU)) * speed * dificulty

func _physics_process(delta):
	if score <= 0.0:
		lose_kid()
	else:
		score -= SADNESS_DEPLETE_RATE*delta*dificulty
		progress_bar.value = score
		
	
	if(!acompañanado):
		var collision = move_and_collide(velocity*delta)
		
		if collision: 
			var bounce_velocity = velocity.bounce(collision.get_normal())
			velocity = bounce_velocity
	#else:
		#follow_player()



