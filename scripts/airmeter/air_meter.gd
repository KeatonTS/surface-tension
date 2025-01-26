extends Control

@onready var bar: TextureProgressBar = $Bar
@export var player: CharacterBody2D
@onready var drain_timer: Timer = $DrainTimer

const FULL = preload("res://graphics/HUD/air meter/full.png")
const LOW = preload("res://graphics/HUD/air meter/low.png")

func _on_drain_speed_timeout() -> void:
	bar.value -= 1

func refill(amount:int):
	bar.value += amount

func stop():
	drain_timer.stop()

func start():
	drain_timer.start()

func _on_bar_value_changed(value: float) -> void:
	if value == 0:
		drain_timer.stop()
		player.pop()
	elif value >= 25:
		bar.texture_progress = FULL
	else:
		bar.texture_progress = LOW
