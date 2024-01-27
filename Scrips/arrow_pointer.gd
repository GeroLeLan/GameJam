extends Node2D

var target_position = null
var origin_position = null


func _physics_process(delta):
	look_at(target_position)
	#position = Vector2(480,270) + 0.9*Vector2(0,-270).rotated(rotation)
