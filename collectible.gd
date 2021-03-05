extends Area2D


#delete collectible on "pickup"
func _on_collectible_body_entered(body):
	queue_free()
