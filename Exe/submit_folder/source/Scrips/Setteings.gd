extends Node2D

const MIN_VALUE =-40

func _ready():
	$Volume.text= str(int($HSlider.ratio * 100)) + "%"
	if(AudioServer.is_bus_mute(AudioServer.get_bus_index('Master'))):
		$HSlider.value = MIN_VALUE
	else:
		$HSlider.value =  AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Master'))

func _on_h_slider_value_changed(value):
	if(value == MIN_VALUE):
		AudioServer.set_bus_mute(AudioServer.get_bus_index('Master'), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index('Master'), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'),value)
	$Volume.text= str(int($HSlider.ratio * 100)) + "%"


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
