extends Area2D

@onready var animp = $AnimationPlayer
@onready var sound1 = $Sound1  # First sound
@onready var sound2 = $Sound2  # Second sound

var sensor = 0
var trigger_count = 0  # To keep track of how many times the action is triggered

func _process(delta):
	# Sensor and pressed "Good"
	if sensor == 1:
		if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
			animp.play("good")
			trigger_count += 1  # Increment the trigger count
			
			# Play different sounds based on the trigger count
			if trigger_count % 5 == 0:
				sound2.play()  # Play the second sound on every 5th trigger
			else:
				sound1.play()  # Play the first sound on all other triggers

func _Idle_ArrowLeft_on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1

func _Idle_ArrowLeft_on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
