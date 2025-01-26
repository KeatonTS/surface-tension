extends Node2D

@onready var bubble: CharacterBody2D = $Bubble
@onready var respawn_point: Marker2D = $RespawnPoint
@onready var camera_2d: Camera2D = $PhantomCamera2D/Camera2D

func reset():
	await get_tree().create_timer(2, false).timeout
	camera_2d.position_smoothing_speed = 5
	camera_2d.position = camera_2d.start_position
	bubble.position = respawn_point.position
	bubble.respawn()


func _on_win_area_body_entered(body):
	if body.name == "Bubble":
		body.set_process(false)
