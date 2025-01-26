extends Node2D


const AIR_BUBBLE = preload("res://scenes/Collectables/air_bubble.tscn")
@onready var bubble: CharacterBody2D = $Bubble
@onready var respawn_point: Marker2D = $RespawnPoint
@onready var camera_2d: Camera2D = $PhantomCamera2D/Camera2D
@onready var air_meter: Control = $HUD/AirMeter
@onready var spawn_points: Node2D = $Collectables/AirBubbles/SpawnPoints
@onready var air_bubbles: Node2D = $Collectables/AirBubbles
@onready var button_face: AnimatedSprite2D = $HUD/ButtonFace
@onready var label: Label = $HUD/Label
@onready var pump_sfx: AudioStreamPlayer = $SFX/Pump
@onready var time_left: Label = $HUD/TimeLeft
@onready var start_timer: Timer = $StartTimer

var started = false

func _ready() -> void:
	spawn_air_bubbles()

func _process(_delta: float) -> void:
	time_left.text = str(roundi(start_timer.time_left))
func reset():
	spawn_air_bubbles()
	await get_tree().create_timer(2, false).timeout
	camera_2d.position_smoothing_speed = 5
	camera_2d.position = camera_2d.start_position
	bubble.position = respawn_point.position
	bubble.respawn()


func _on_win_area_body_entered(body):
	if body.name == "Bubble":
		body.set_process(false)
func spawn_air_bubbles():
	if not air_bubbles.get_children().is_empty():
		for bubble in air_bubbles.get_children():
			if bubble is StaticBody2D:
				bubble.queue_free()
		
	for location in spawn_points.get_children():
		var new_bubble = AIR_BUBBLE.instantiate()
		new_bubble.position = location.position
		air_bubbles.call_deferred("add_child", new_bubble)
		new_bubble.level = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("push") and Input.is_action_just_pressed("push"):
		air_meter.bar.value += 2
		pump_sfx.play()


func _on_start_timer_timeout() -> void:
	bubble.start()
	button_face.hide()
	label.hide()
	time_left.hide()
	air_meter.start()
	set_process_input(false)
	started = true
	
	
