extends Area2D

signal collided_player

const SPEED = -30

var v = Vector2(SPEED, 0)

func _physics_process(delta):
	position += v * delta



func _on_laser_body_entered(body):
	emit_signal("collided_player")
	queue_free()
