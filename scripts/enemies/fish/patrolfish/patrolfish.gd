extends Sprite2D
var flipped: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if flipped == false:
		position.x += 2
	else:
		position.x -= 2

func _on_right_body_entered(body):
	if flipped == true:
		flip_h = false
		flipped = false
	else:
		flip_h = true
		flipped = true
		
func _on_left_body_entered(body):
	if flipped == false:
		flip_h = true
		flipped = true
	else:
		flip_h = false
		flipped = false # Replace with function body.
