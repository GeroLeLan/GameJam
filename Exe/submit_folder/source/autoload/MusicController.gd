extends Node

var musicaMenu = load("res://audio/menu/menu3.ogg")

func play_music():
	$Music.stream = musicaMenu
	$Music.play()
func stop_music_menu():
	$Music.stop()







# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
