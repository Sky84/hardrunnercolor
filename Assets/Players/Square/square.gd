extends Player

@onready var yellow_ray_cast_2d: RayCast2D = $Raycasts/YellowRayCast2D
@onready var blue_ray_cast_2d: RayCast2D = $Raycasts/BlueRayCast2D3
@onready var green_ray_cast_2d: RayCast2D = $Raycasts/GreenRayCast2D4
@onready var red_ray_cast_2d: RayCast2D = $Raycasts/RedRayCast2D2

class RaycastColor:
	var raycast: RayCast2D;
	var color: Color;
	func _init(raycast: RayCast2D, color: Color) -> void:
		self.raycast = raycast
		self.color = color

#declaring dictionary that mapping the roation and raycasts
@onready var _ray_casts = {
	0: RaycastColor.new(yellow_ray_cast_2d, Color.YELLOW),
	90: RaycastColor.new(blue_ray_cast_2d, Color.BLUE),
	180: RaycastColor.new(green_ray_cast_2d, Color.GREEN),
	270: RaycastColor.new(red_ray_cast_2d, Color.RED)
}

func _physics_process(delta):
	super(delta);
	for raycast_key_rotation in _ray_casts:
		var raycast_color: RaycastColor = _ray_casts[raycast_key_rotation];
		if raycast_color.raycast.is_colliding() and current_color != raycast_color.color:
			_on_collision_raycast(raycast_color);

func _on_collision_raycast(_raycast_color: RaycastColor) -> void:
	current_color = _raycast_color.color;

# when player press the screen or the mouse button, rotate the player at 90 degrees relative to the current roation
func _input(event: InputEvent) -> void:
	super(event);
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.is_pressed():
		var desired_rotation = round((rotation_degrees + 90) / 90) * 90;
		#tween the rotation of the player
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", desired_rotation, 0.1).set_delay(0.1);
