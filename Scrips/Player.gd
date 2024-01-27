extends CharacterBody2D

const MAX_VELOCITY = 300

func get_chain():
	return array

var array = []
var offsetX = -30
var offsetY = -30



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


func set_arrow_target(t1,t2):
	$Arrow1.origin_position = position
	$Arrow2.origin_position = position
	$Arrow1.target_position = t1
	$Arrow2.target_position = t2

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
	#print(array)

func removeFromArray(children):
	if array.size() > 0:
		if array.front() == children and array.size() > 1:
			array[1].target = self
		elif array.back() != children:
			var index = array.find(children)
			array[index+1].target = array[index-1]
		array.erase(children)
