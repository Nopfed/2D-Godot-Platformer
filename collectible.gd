extends Area2D

signal collectible_collected

#delete collectible on "pickup"
func _on_collectible_body_entered(body):
	
	emit_signal("collectible_collected")
	
	queue_free()
