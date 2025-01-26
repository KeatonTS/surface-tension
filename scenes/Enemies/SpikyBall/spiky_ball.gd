extends Node2D
@onready var pivot = $Pivot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pivot.rotation == 360:
		pivot.rotation = 0
	pivot.rotation += .025

func _on_ball_area_body_entered(body):
	if body.is_in_group("Bubble"):
		body.pop()
