extends StaticBody2D

@onready var spikes: Node2D = $body/Spikes
@onready var spike_1: Sprite2D = $body/Spikes/Spike1
@onready var spike_2: Sprite2D = $body/Spikes/Spike2
@onready var spike_3: Sprite2D = $body/Spikes/Spike3
@onready var spike_4: Sprite2D = $body/Spikes/Spike4

@onready var spike_1_pos = spike_1.global_position
@onready var spike_2_pos = spike_2.global_position
@onready var spike_3_pos = spike_3.global_position
@onready var spike_4_pos = spike_4.global_position

@onready var reload_timer: Timer = $ReloadTimer
@onready var fire_timer: Timer = $FireTimer
@onready var fired_spikes: Node2D = $FiredSpikes
@onready var spike_pos_list: Node2D = $body/SpikePosList


const TOP_LEFT_SEGMENT = preload("res://scenes/Enemies/urchin/top_left_segment.tscn")
const TOP_RIGHT_SEGMENT = preload("res://scenes/Enemies/urchin/top_right_segment.tscn")
const BOTTOM_LEFT_SEGMENT = preload("res://scenes/Enemies/urchin/bottom_left_segment.tscn")
const BOTTOM_RIGHT_SEGMENT = preload("res://scenes/Enemies/urchin/bottom_right_segment.tscn")

var spike_segment_list = [TOP_LEFT_SEGMENT, TOP_RIGHT_SEGMENT, BOTTOM_LEFT_SEGMENT, BOTTOM_RIGHT_SEGMENT]
var spike_tween_1
var spike_tween_2
var spike_tween_3
var spike_tween_4

var is_ready = true
var active = false

func extract():
	spike_tween_1 = create_tween().set_parallel()
	spike_tween_2 = create_tween().set_parallel()
	spike_tween_3 = create_tween().set_parallel()
	spike_tween_4 = create_tween().set_parallel()

	spike_tween_1.tween_property(spike_1, "global_position", spike_1_pos, 0.5)
	spike_tween_2.tween_property(spike_2, "global_position", spike_2_pos, 0.5)
	spike_tween_3.tween_property(spike_3, "global_position", spike_3_pos, 0.5)
	spike_tween_4.tween_property(spike_4, "global_position", spike_4_pos, 0.5)
	await spike_tween_4.finished
	is_ready = true 

func fire():
	var scale_tween = create_tween()
	scale = Vector2(0.6, 0.65)
	scale_tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.25)
	var index = 0
	
	# Adds a new spike for each position
	for spike in spike_segment_list:
		var new_spike = spike.instantiate()
		fired_spikes.call_deferred("add_child", new_spike)
		new_spike.position = spike_pos_list.get_child(index).position
		index += 1
	
	# Retract spikes
	for spike in spikes.get_children():
		spike.position = Vector2.ZERO
		
	reload_timer.start()


func _on_reload_timer_timeout() -> void:
	extract()


func _on_fire_timer_timeout() -> void:
	if is_ready and active:
		fire()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	active = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	active = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bubble"):
		body.pop()
