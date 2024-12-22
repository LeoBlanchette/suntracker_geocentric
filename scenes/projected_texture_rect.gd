extends TextureRect

const POINT = preload("res://scenes/point.tscn")

@export var main:Main

func _ready():
	# Connect the signal from the Main script to update the UV coordinates
	main.current_sun_ray_hit_updated.connect(_on_current_sun_ray_hit_updated)

func _on_current_sun_ray_hit_updated(uv:Vector2):
	return
	# Ensure UV coordinates are within the range [0, 1]
	print(uv)
	# Convert UV coordinates to position within the TextureRect
	var position:Vector2 = uv * size

	# Create and position the point instance
	var point_instance:ColorRect = POINT.instantiate()
	add_child(point_instance)
	#point_instance.rect_min_size = Vector2(5, 5)  # Set a fixed size for visibility
	point_instance.position = position - point_instance.get_minimum_size() / 2  # Center the point
