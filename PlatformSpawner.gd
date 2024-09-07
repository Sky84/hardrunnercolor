extends Node2D

@onready var game_rules: GameRules = $"../GameRules";
@onready var platforms_container: Node2D = $Platforms;
@export var platforms: Array[AnimatableBody2D];
@export var obstacles: Array[AnimatableBody2D];

var PLATFORM_TYPE = [
	'Red',
	'Blue',
	'Yellow',
	'Green'
]

func _physics_process(delta):
	for platform in platforms:
		platform.global_position.x += game_rules.speed.x * delta;
		var platform_max_right = platform.global_position.x + platform.platform_width;
		if platform_max_right < 0:
			platform.global_position.x = get_viewport_rect().size.x;
			platform.platform_type = PLATFORM_TYPE[randi() % PLATFORM_TYPE.size()];
			var _with_obstacle = randi_range(0, 1) == 0;
			#if _with_obstacle:
				#var obstacle = obstacles[randi() % obstacles.size()];
				#obstacle.global_position.x = platform.global_position.x + randi_range(0, platform.platform_width);
				#obstacle.obstacle_type = platform.platform_type;
				#obstacle.obstacle_speed = game_rules.speed
