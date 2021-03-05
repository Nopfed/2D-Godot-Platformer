extends CanvasLayer

var collectibles = 0

#initialize
func _ready():
	$Collectibles.text = String(collectibles)


func _on_collectible_collected():
	collectibles += 1
	$Collectibles.text = String(collectibles)
