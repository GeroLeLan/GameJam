extends Node2D

var game_ref = null
var target_position = null
var origin_position = null
var color_array = [Color.GREEN, Color.YELLOW, Color.RED]

func _physics_process(delta):
	look_at(target_position)
	var timer_value = game_ref.zone_randomizer.time_left
	var max_value = game_ref.zone_randomizer.wait_time
	if (timer_value > 2*(max_value/3)):
		modulate = color_array[0]
	elif (timer_value > (max_value/3)):
		modulate = color_array[1]
	else:
		modulate = color_array[2]

