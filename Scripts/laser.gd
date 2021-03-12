extends Area2D

const SPEED = -250

var v = Vector2(SPEED, 0)

func _physics_process(delta):
	position += v * delta



func _on_laser_body_entered(body):
	if body.is_in_group("player"):
		get_tree().get_root().get_node(get_tree().current_scene.name +"/"+ "player").playing = false
		visible = false
		position = Vector2.ZERO
		$"death sound".play()
		yield($"death sound", "finished")
		get_tree().reload_current_scene()
	else:
		queue_free()
	
