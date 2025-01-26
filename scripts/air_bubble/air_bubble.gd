extends StaticBody2D


@onready var refill_sfx: AudioStreamPlayer = $SFX/Refill
@onready var area_2d: Area2D = $Area2D
@onready var bubbles: GPUParticles2D = $Bubbles
@onready var up_position = global_position.y - 10
@onready var down_position = global_position.y + 10
@export var level:Node2D
var refill_amount = 15

func _ready() -> void:
	var float_tween = create_tween().set_loops()
	float_tween.tween_property(self, "position:y", up_position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	float_tween.tween_property(self, "position:y", down_position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bubble"):
		hide()
		bubbles.emitting = false
		refill_sfx.play()
		area_2d.set_deferred("monitoring", false)
		level.air_meter.refill(refill_amount)
		await refill_sfx.finished
		queue_free()
