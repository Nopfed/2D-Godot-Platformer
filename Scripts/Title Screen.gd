extends Control

var file_path = "user://checkpoint.dat"

func _ready():
	var file = File.new()
	var error = file.open(file_path, File.WRITE)
	
	if error == OK:
		file.store_var(Vector2(104, -88))
		file.close()
