extends Area2D


func _on_win_zone_body_entered(body):
	$"win sound".play()
	yield($"win sound", "finished")
	get_tree().change_scene("res://Scenes/levels/level 1.tscn")
