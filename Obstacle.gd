@tool
extends AnimatableBody2D

const obstacle_scenes = {
	"spike":preload("res://Assets/Obstacles/spike.png")
}

@export var sprite_obstacle: Sprite2D;

@export_enum('None', 'Spike') var obstacle_type: String:
	get:
		return _obstacle_type.to_pascal_case();
	set(value):
		if sprite_obstacle and value:
			_obstacle_type = value.to_lower();
			sprite_obstacle.texture = obstacle_scenes[_obstacle_type];

var _obstacle_type: String;

@onready var obstacle_width = $CollisionShape2D.shape.get_rect().size.x;
