extends Camera2D
const SPD = 200.0
var run = true 
func _process(delta):
	if run:
		position.x += SPD*delta
	
