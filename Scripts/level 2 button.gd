extends Button


func _on_Button_pressed():
	$boop2.play()
	yield($boop2,"finished")
	get_tree().change_scene("res://Scenes/levels/level 2.tscn")


func _on_Button_mouse_entered():
	$boop1.play()
