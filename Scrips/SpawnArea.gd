extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var kid = preload("res://Scenes/pibito.tscn").instantiate()
	get_parent().add_child(kid)
	var area = $CollisionShape2D
	var largo = area.shape.extents.x * 2
	var ancho = area.shape.extents.y * 2

	var position = Vector2(randf() * largo, randf() * ancho)
	kid.position = position