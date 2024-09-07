extends Node2D

@onready var game_rules: GameRules = $"../GameRules";
@onready var platforms_container: Node2D = $Platforms;
@export var obstacles_scenes: Array[PackedScene];
@export var platforms: Array[AnimatableBody2D];
var _obstacles: Array[AnimatableBody2D];

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
			_on_platform_replaced(platform);
	for obstacle in _obstacles:
		obstacle.global_position.x += game_rules.speed.x * delta;
		var obstacle_max_right = obstacle.global_position.x + obstacle.obstacle_width;
		if obstacle_max_right < 0:
			obstacle.queue_free();
			_obstacles.erase(obstacle);

func _on_platform_replaced(_platform: AnimatableBody2D):
	_platform.platform_type = PLATFORM_TYPE[randi() % PLATFORM_TYPE.size()];
	var _with_obstacle = randi_range(0, 1) == 0;
	if _with_obstacle:
		var _obstacle_scene = obstacles_scenes[randi() % obstacles_scenes.size()];
		var _obstacle_instance = _obstacle_scene.instantiate();
		_obstacle_instance.global_position.x = get_viewport_rect().size.x + randi_range(0, _platform.platform_width);
		platforms_container.add_child(_obstacle_instance);
		_obstacles.append(_obstacle_instance);