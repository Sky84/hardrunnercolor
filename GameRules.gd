extends Node2D
class_name GameRules

@export var score_before_obstacle_spawns: int = 15000;
@export var time_s_before_increase_speed: int = 1;
@export var start_speed: Vector2;
@export var speed_increase: Vector2;
@export var gravity: Vector2;
@export var colors: Array[Color];
@onready var score_rich_text_label: RichTextLabel = $"../CanvasLayer/HUD/RichTextLabel"
const score_rich_text_base: String = "[center][font_size=128]{score}[/font_size][/center]";

var speed: Vector2;

var player_score: int = 0;

@onready var player: Player = $"../Player";

@onready var colors_by_score = {
	0: [colors[0]],
	500: [colors[0], colors[1]],
	2000: [colors[0], colors[1], colors[2]],
	5000: [colors[0], colors[1], colors[2], colors[3]]
}

func start_game() -> void:
	speed = start_speed;
	var _timer = Timer.new();
	_timer.wait_time = time_s_before_increase_speed;
	_timer.autostart = true;
	add_child(_timer);
	_timer.timeout.connect(_on_timer_timeout);
	player.score_should_increase.connect(_on_increase_score);

func _on_timer_timeout():
	speed += speed_increase;

func _on_increase_score():
	player_score += 100;
	score_rich_text_label.text = score_rich_text_base.replace("{score}", str(player_score));
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE);
	tween.tween_property(score_rich_text_label, "scale", Vector2(1.1, 1.1), 0.2);
	tween.tween_property(score_rich_text_label, "scale", Vector2.ONE, 0.2);

func get_next_platform_type() -> Color:
	var keys = colors_by_score.keys();
	var first_key = keys[0]
	var _colors = colors_by_score[first_key];
	for color_score_min in colors_by_score:
		if player_score > color_score_min:
			_colors = colors_by_score[color_score_min];
	return _colors[randi() % _colors.size()];


func is_obstacle_spawnable() -> bool:
	return player_score >= score_before_obstacle_spawns and randi_range(0, 2) == 0;
