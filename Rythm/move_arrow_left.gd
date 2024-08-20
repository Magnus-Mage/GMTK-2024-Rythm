extends Area2D

var speed = 100

var sensor = 0

func _process(delta):
	
	#Move
	
	position.x -= speed * delta

	#Screen exited
	
	if position.x < -50:
		queue_free()
		print("exited")
	
	#Sensor and pressed
	if sensor == 1:
		#Add  Global > new
		if Global.sensor_AL == 1:
			if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("left") :
				queue_free()

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	


func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
