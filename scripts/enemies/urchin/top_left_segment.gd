extends StaticBody2D

var speed = 200

func _physics_process(_delta: float) -> void:
	global_position.y -= speed * _delta
	global_position.x -= speed * _delta

func _on_life_timer_timeout() -> void:
	queue_free()


func _on_spike_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bubble"):
		queue_free()
