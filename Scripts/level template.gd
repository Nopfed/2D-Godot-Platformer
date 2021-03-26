extends Node2D

var file_path = "user://checkpoint.dat"


func _on_checkpoint_body_entered(body):
	var file = File.new()
	var error = file.open(file_path, File.WRITE)
	
	if error == OK:
		file.store_var(body.position)
		file.close()
