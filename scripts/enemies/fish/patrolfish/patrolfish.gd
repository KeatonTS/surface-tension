extends Sprite2D
var flipped: bool = false
@export var swim_speed: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if flipped == false:
		position.x += swim_speed
	else:
		position.x -= swim_speed

func _on_right_body_entered(body):
	if body.is_in_group("Bubble"):
		return
	if flipped == true:
		flip_h = false
		flipped = false
	else:
		flip_h = true
		flipped = true

func _on_left_body_entered(body):
	if body.is_in_group("Bubble"):
		return
	if flipped == false:
		flip_h = true
		flipped = true
	else:
		flip_h = false
		flipped = false # Replace with function body.


func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bubble"):
		body.pop()
