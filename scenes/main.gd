extends Node3D

class_name Main

const NODE_POINT_3D = preload("res://scenes/node_point_3d.tscn")

@export var ui: UI
@export var spinning_globe: SpinningGlobe
@export var sun_ray_cast_3d: RayCast3D 

@export var current_sun_ray_hit_uv: Vector2 = Vector2():
	set(value):
		current_sun_ray_hit_uv = value
		current_sun_ray_hit_updated.emit(value)

signal current_sun_ray_hit_updated(uv:Vector2)

func _ready():
	# Connect UI signals to their respective callback functions
	ui.play_button.pressed.connect(_on_play_button_pressed)
	ui.stop_button.pressed.connect(_on_stop_button_pressed)
	ui.total_secons_input.text_submitted.connect(_on_total_seconds_input_submitted)

func _on_play_button_pressed():
	# Set the duration of one year in the simulation based on user input
	spinning_globe.seconds_in_a_year = ui.total_secons_input.text.to_float()
	# Start the spinning globe simulation
	spinning_globe.start()
	# Enable processing
	set_process(true)

func _on_stop_button_pressed():
	# Stop the spinning globe simulation
	spinning_globe.stop()
	# Disable processing
	set_process(false)

func _on_total_seconds_input_submitted(new_value: String):
	# Update the duration of one year in the simulation based on user input
	var new_seconds_in_a_year: float = new_value.to_float()
	spinning_globe.seconds_in_a_year = new_seconds_in_a_year
	ui.seconds_in_a_year = new_seconds_in_a_year

func _process(_delta: float):
	# Update UI labels with the current simulation data
	ui.seconds_elapsed_label.text = "Seconds Elapsed: " + str(snapped(spinning_globe.seconds_elapsed, 0.1))
	ui.seconds_remaining_label.text = "Seconds Remaining: " + str(snapped(spinning_globe.seconds_remaining, 0.1))
	ui.percentage_complete_label.text = "Percentage Complete: " + str(snapped(spinning_globe.percentage_complete, 0.1))
	
	# Check if the sun's ray is colliding with the globe
	if sun_ray_cast_3d.is_colliding():
		# Get the collision point and face index
		var collision_point: Vector3 = sun_ray_cast_3d.get_collision_point()
		attach_point_3d(collision_point)
		

## Just for testing. Do not use.
func attach_point_3d(pos: Vector3):
	return #for now
	# Create and attach a 3D point instance at the specified position
	var point_instance: Node3D = NODE_POINT_3D.instantiate()

	spinning_globe.add_child(point_instance)
	point_instance.global_position = pos
