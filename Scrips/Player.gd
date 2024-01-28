extends CharacterBody2D

const MAX_VELOCITY = 300

func get_chain():
	return array

var array = []
var offsetX = -30
var offsetY = -30
var lastMovement = Vector2.ZERO
var xSize
var arrow 

func _ready():
	xSize = transform.x.x
	arrow = null
func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x= Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left") 
	direction.y= Input.get_action_strength("Move_Down") - Input.get_action_strength("Move_Up") 
	direction.normalized()
	
	if Input.is_action_just_pressed("honk_input"):
		$HonkPlayer.play(0.0)

	if(direction):
		velocity = direction * MAX_VELOCITY
		if(direction.x):
			transform.x= Vector2(direction.x*xSize,0)
			$Camera2D.transform.x= Vector2(direction.x,0)
	else:
		velocity = direction
	
	if(velocity != Vector2.ZERO or lastMovement!= Vector2.ZERO):
		if($AnimatedSprite2D.animation!="Star_movement") and ($AnimatedSprite2D.animation!="movement"):
			$AnimatedSprite2D.play("Star_movement")
		if($AnimatedSprite2D.animation=="Star_movement") and ($AnimatedSprite2D.animation!="movement" and $AnimatedSprite2D.frame_progress == 1.0):
			$AnimatedSprite2D.play("movement")
	else:
		if($AnimatedSprite2D.animation!="End_movement") and ($AnimatedSprite2D.animation!="default"):
			$AnimatedSprite2D.play("End_movement")
		if($AnimatedSprite2D.animation=="End_movement") and ($AnimatedSprite2D.animation!="default" and $AnimatedSprite2D.frame_progress == 1.0):
			$AnimatedSprite2D.play("default")
	lastMovement = velocity
	move_and_slide() 


func set_arrow_target(target):
	if (arrow == null):
		arrow = preload("res://Scenes/arrow_pointer.tscn").instantiate()
		arrow.origin_position = position
		arrow.game_ref = get_parent()
		arrow.target_position = target.global_position
		arrow.modulate = arrow.color_array[0]
		add_child(arrow)
	else:
		arrow.origin_position = position
		arrow.target_position = target.global_position
		arrow.modulate = arrow.color_array[0]
		
	


func _on_child_colector_body_entered(body):
	if body.is_in_group("children"):
		if(!body.acompañanado):
			var target
			# Si esta solo, el target es player, sino el del final
			if array.is_empty():
				target = self
			else:
				target = array.back()
			body.capture_kid(target)
			body.player_ref = self
			#body.collision_shape_2d.disabled = true
			body.set_collision(false)
			array.append(body)
		
func getposition():
	var relative_pos = position
	relative_pos.x += offsetX
	relative_pos.y += offsetY
	offsetX -=20
	offsetY -=20
	return relative_pos

func addArray(value):
	array.append(value)

func removeFromArray(children):
	if array.size() > 0:
		if array.front() == children and array.size() > 1:
			array[1].target = self
		elif array.back() != children:
			var index = array.find(children)
			array[index+1].target = array[index-1]
		array.erase(children)
