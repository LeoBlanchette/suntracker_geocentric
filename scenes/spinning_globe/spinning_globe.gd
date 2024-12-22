extends Node3D

class_name SpinningGlobe

@export var sphere_mesh_instance_3d:MeshInstance3D

@export var seconds_in_a_year: float = 60.0  # Default to 60 seconds for one year
const FULL_ROTATION = 360.0   # Full rotation in degrees
const TILT_ANGLE = 23.5       # Earth's axial tilt in degrees

var seconds_elapsed: float = 0.0  # Total seconds elapsed in the simulation
var daily_rotation_angle: float = 0.0  # Keep track of accumulated daily rotation
var seconds_remaining: float = 0.0  # Total seconds remaining in the simulation
var percentage_complete: float = 0.0  # Percentage of the year completed in the simulation

func _ready():
	# Apply the tilt ONCE in _ready. This is crucial!
	rotate_object_local(Vector3.RIGHT, deg_to_rad(-TILT_ANGLE))
	set_process(false)

func start():
	seconds_elapsed = 0.0
	daily_rotation_angle = 0.0
	set_process(true)

func stop():
	set_process(false)

func _process(delta):
	seconds_elapsed += delta

	var seconds_in_a_day = seconds_in_a_year / 365.25
	var daily_rotation_speed = FULL_ROTATION / seconds_in_a_day  # Degrees per second

	# Increment the daily rotation
	daily_rotation_angle += daily_rotation_speed * delta
	daily_rotation_angle = fmod(daily_rotation_angle, 360.0)  # Keep it within 0-360

	# Apply the daily rotation around the Y-axis
	rotation_degrees.y = daily_rotation_angle

	# Calculate the percentage of the year completed
	percentage_complete = (seconds_elapsed / seconds_in_a_year) * 100.0

	# Calculate the total seconds remaining in the simulation
	seconds_remaining = seconds_in_a_year - seconds_elapsed

	# For demonstrating the yearly cycle (optional visualization)
	var yearly_progress = fmod(seconds_elapsed, seconds_in_a_year) / seconds_in_a_year
	# You could use this 'yearly_progress' to control other yearly effects,
	# like the position of a light source representing the Sun.
