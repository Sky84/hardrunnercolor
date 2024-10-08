extends Node2D

@onready var game_rules: GameRules = $"../GameRules";
@onready var platforms_container: Node2D = $Platforms;
@onready var _objects_container: Node2D = $Objects;
@export var obstacles_scenes: Array[PackedScene];
@export var optional_platforms_scenes: Array[PackedScene];
@export var platforms: Array[AnimatableBody2D];

var _objects: Array[AnimatableBody2D];

func _physics_process(delta):
	for platform in platforms:
		platform.global_position.x += game_rules.speed.x * delta;
		var platform_max_right = platform.global_position.x + platform.platform_width;
		if platform_max_right < 0:
			# find the rightest platform
			var right_most_platform_X: int = platforms.map(func(p): return p.position.x + p.platform_width).max();
			platform.global_position.x = right_most_platform_X;
			_on_platform_replaced(platform);
	for object in _objects:
		var object_max_right = object.global_position.x + object.object_width;
		object.global_position.x += game_rules.speed.x * delta;
		if object_max_right < 0:
			object.queue_free();
			_objects.erase(object);

func _on_platform_replaced(_platform: AnimatableBody2D):
	_platform.platform_type = game_rules.get_next_platform_type();
	_try_spawn_obstacle(_platform);
	_try_spawn_optional_platform(_platform);

func _try_spawn_obstacle(_platform: AnimatableBody2D):
	var _with_obstacle = game_rules.is_obstacle_spawnable();
	if _with_obstacle:
		var _obstacle_scene = obstacles_scenes[randi() % obstacles_scenes.size()];
		var _obstacle_instance = _obstacle_scene.instantiate();
		_obstacle_instance.global_position.x = get_viewport_rect().size.x + randi_range(0, _platform.platform_width);
		_objects_container.add_child(_obstacle_instance);
		_objects.append(_obstacle_instance);

func _try_spawn_optional_platform(_platform: AnimatableBody2D):
	var _with_optional_platform = game_rules.is_optional_platform_spawnable();
	if _with_optional_platform:
		var _optional_platform_scene = optional_platforms_scenes[randi() % optional_platforms_scenes.size()];
		var _optional_platform_instance = _optional_platform_scene.instantiate();
		_optional_platform_instance.global_position.x = get_viewport_rect().size.x + randi_range(0, _platform.platform_width);
		_optional_platform_instance.global_position.y = _platform.global_position.y - randi_range(0, get_viewport_rect().size.y/2);
		_objects_container.add_child(_optional_platform_instance);
		_objects.append(_optional_platform_instance);
