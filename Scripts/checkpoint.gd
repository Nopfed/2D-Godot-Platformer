extends Area2D


func _on_checkpoint_body_entered(body):
	if body.is_in_group(player):
		
