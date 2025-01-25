extends Sprite2D
var flipped: bool = false
var chase: bool = false
@export var player: CharacterBody2D
@onready var detection = $Detection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase:
		position = position.move_toward(player.position, delta * 125)

	else:
		if flipped == false:
			position.x += 100 * delta
		else:
			position.x -= 100 * delta 

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

func _on_detection_body_entered(body):
	if body.name == "Bubble":
		chase = true

func _on_detection_body_exited(body):
	if body.name == "Bubble":
		chase = false
