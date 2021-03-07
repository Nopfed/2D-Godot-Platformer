extends Button




func _on_Play_Button_pressed():
	$boop2.play()
	yield($boop2,"finished")
	get_tree().quit()




func _on_Play_Button_mouse_entered():
	$boop1.play()
