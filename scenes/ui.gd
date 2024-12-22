extends Control

class_name UI

# This is where the projected sun path is drawn.
#@export var projected_texture_rect: ProjectedTextureRect 

# Exported variables to allow the user to adjust the duration of one year in the simulation
@export var seconds_in_a_year: float = 3600.0  # Default to 3600 seconds for one year

# UI Controls
@export var total_secons_input: LineEdit
@export var play_button: Button
@export var stop_button: Button

# UI elements to display the time information
@export var seconds_elapsed_label: RichTextLabel
@export var seconds_remaining_label: RichTextLabel
@export var percentage_complete_label: RichTextLabel
