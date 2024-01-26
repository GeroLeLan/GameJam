extends CharacterBody2D

const MAX_VELOCITY = 300

func get_chain():
	return [10,20,30]


func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x= Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left") 
	direction.y= Input.get_action_strength("Move_Down") - Input.get_action_strength("Move_Up") 
	direction.normalized()
	
	if(direction):
		velocity = direction * MAX_VELOCITY
	else:
		velocity = direction
	move_and_slide() 


func _on_child_colector_body_entered(body):
	if body.is_in_group("children"):
		body.capture_kid()
		
