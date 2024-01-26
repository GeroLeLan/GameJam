extends CharacterBody2D

const MAX_VELOCITY = 300

func get_chain():
	return [10,20,30]

var array = []
var offsetX = -30
var offsetY = -30

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x= Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left") 
	direction.y= Input.get_action_strength("Move_Down") - Input.get_action_strength("Move_Up") 
	direction.normalized()
	#print(array)
	if(direction):
		velocity = direction * MAX_VELOCITY
		for children in array:
			children.follow_player(velocity)
	else:
		velocity = direction
	move_and_slide() 


func _on_child_colector_body_entered(body):
	if body.is_in_group("children"):
		if(!body.acompañanado):
			body.capture_kid()
		
func getposition():
	var relative_pos = position
	relative_pos.x += offsetX
	relative_pos.y += offsetY
	offsetX -=20
	offsetY -=20
	return relative_pos

func addArray(value):
	array.append(value)
	#print(array)

func removeFromArray(children):
	array.erase(children)
