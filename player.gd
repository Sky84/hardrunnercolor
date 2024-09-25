extends CharacterBody2D

@export var jump_force: float = 100;

@onready var yellow_ray_cast_2d: RayCast2D = $Raycasts/YellowRayCast2D
@onready var blue_ray_cast_2d: RayCast2D = $Raycasts/BlueRayCast2D3
@onready var green_ray_cast_2d: RayCast2D = $Raycasts/GreenRayCast2D4
@onready var red_ray_cast_2d: RayCast2D = $Raycasts/RedRayCast2D2

@onready var game_rules: GameRules = $"../GameRules";

@onready var start_position: Vector2 = position;

var _want_jump: bool = false;

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

var _current_color: Color;

func _process(delta: float) -> void:
	position.x = start_position.x;

func _physics_process(delta):
	# lock player x axis to current start x position
	if not is_on_floor():
		velocity.y += game_rules.gravity.y * delta;
	elif _want_jump: 
		_want_jump = false;
		velocity.y = -jump_force;
	else:
		velocity.y = 0;
	velocity.x = 0;
	
	move_and_slide();
	for raycast_key_rotation in _ray_casts:
		var raycast_color: RaycastColor = _ray_casts[raycast_key_rotation];
		if raycast_color.raycast.is_colliding() and _current_color != raycast_color.color:
			_on_collision_raycast(raycast_color);

func _on_collision_raycast(_raycast_color: RaycastColor) -> void:
	_current_color = _raycast_color.color;

# when player press the screen or the mouse button, rotate the player at 90 degrees relative to the current roation
func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.is_pressed():
		var desired_rotation = round((rotation_degrees + 90) / 90) * 90;
		#tween the rotation of the player
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", desired_rotation, 0.1).set_delay(0.1);
		if is_on_floor():
			_want_jump = true;
