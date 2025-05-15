class_name Bullet extends Hitbox

const BULLET_COLLISION_LAYER: int = 4
const BULLET_SIZE := Vector2(42, 12)


var speed: float
var direction: Vector2
var life_time: float

var time_passed: float = 0

func _init(p_attack_resource: AttackResource ,p_speed: float, p_direction: Vector2, p_life_time: float, texture: Texture2D) -> void:
	#super._init() this is so the bullet may know when it hits a wall
	attack_resource = p_attack_resource
	speed = p_speed
	direction = p_direction
	life_time = p_life_time
	
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	hit.connect(_on_hit)
	collision_layer = BULLET_COLLISION_LAYER
	
	_init_sprite(texture)
	_init_collision_shape()

func _init_collision_shape() -> void:
	var rectangle_shape2d := RectangleShape2D.new()
	rectangle_shape2d.size = BULLET_SIZE
	
	var collision_shape:= CollisionShape2D.new()
	collision_shape.shape = rectangle_shape2d
	
	add_child(collision_shape)

func _init_sprite(texture: Texture2D) -> void:
	var new_sprite := Sprite2D.new()
	new_sprite.texture = texture
	add_child(new_sprite)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= life_time:
		_destroy_on_timeout()

func _destroy_on_hit() -> void:
	print('destroy on hit')
	queue_free()

func _destroy_on_timeout() -> void:
	print('destroy on timeout')
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	_destroy_on_hit()

func _on_body_entered(_body: Node2D) -> void:
	_destroy_on_hit()

func _on_hit(_attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2):
	_destroy_on_hit()
