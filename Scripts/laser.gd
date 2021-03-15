extends Area2D

const SPEED = -250

var v = Vector2(SPEED, 0)

func _physics_process(delta):
	position += v * delta



func _on_laser_body_entered(body):
	if body.is_in_group("player"):
		#visible = false
		#position *= 0
		body.kill()
	else:
		queue_free()
	
