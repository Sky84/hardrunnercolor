extends Node2D
class_name GameRules

@export var time_s_before_increase_speed: int = 1;
@export var speed: Vector2;
@export var speed_increase: Vector2;
@export var gravity: Vector2;
@export var colors: Array[Color];

# Called when the node enters the scene tree for the first time.
func _ready():
	# increase speed by speed_increase every 10 seconds
	var _timer = Timer.new();
	_timer.wait_time = time_s_before_increase_speed;
	_timer.autostart = true;
	add_child(_timer);
	_timer.timeout.connect(_on_timer_timeout);

func _on_timer_timeout():
	speed += speed_increase;
