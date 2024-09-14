extends Node2D

@onready var yellow_ray_cast_2d: RayCast2D = $Raycasts/YellowRayCast2D
@onready var blue_ray_cast_2d: RayCast2D = $Raycasts/BlueRayCast2D3
@onready var green_ray_cast_2d: RayCast2D = $Raycasts/GreenRayCast2D4
@onready var red_ray_cast_2d: RayCast2D = $Raycasts/RedRayCast2D2


#declaring dictionary that mapping the roation and raycasts
var _ray_casts = {
	0: yellow_ray_cast_2d,
	90: blue_ray_cast_2d,
	180: green_ray_cast_2d,
	270: red_ray_cast_2d
}

var _current_color: Color;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# when player press the screen or the mouse button, rotate the player at 90 degrees relative to the current roation
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		rotation_degrees = fmod(rotation_degrees + 90, 360);
		
 
