extends CharacterBody2D
class_name Player

@export var jump_force: float = 100;

@onready var game_rules: GameRules = $"../GameRules";

@onready var start_position: Vector2 = position;

var _want_jump: bool = false;
var want_change_color: bool = false;

var current_color: Color;

var speed_animation: float:
	get:
		return game_rules.speed.x / game_rules.start_speed.x;

signal score_should_increase;

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
	
	if get_platform_velocity().y != 0:
		apply_floor_snap();

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.is_pressed():
		want_change_color = true;
	# if swipe to up direction, jump
	if event is InputEventScreenDrag and event.relative.y < 0\
	 or event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		if is_on_floor():
			_want_jump = true;

func on_first_play():
	pass

func on_score_should_increase():
	score_should_increase.emit();
