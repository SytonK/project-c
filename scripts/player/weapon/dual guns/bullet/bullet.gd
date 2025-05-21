class_name Bullet extends CharacterBody2D

const BULLET_COLLISION_LAYER: int = 4
const BULLET_SIZE := Vector2(42, 12)

var speed: float
var direction: Vector2
var life_time: float
var attack_resource: AttackResource
var bounce: bool

var time_passed: float = 0

func _init(p_attack_resource: AttackResource ,p_speed: float, p_direction: Vector2, p_life_time: float, texture: Texture2D, p_bounce: bool = false) -> void:
	attack_resource = p_attack_resource
	speed = p_speed
	direction = p_direction
	life_time = p_life_time
	bounce = p_bounce
	rotation = direction.angle()
	_init_collision()
	add_child(_get_collision_shape())
	_init_sprite(texture)
	_init_hitbox()

func _init_collision() -> void:
	collision_layer = 0

func _get_collision_shape() -> CollisionShape2D:
	var rectangle_shape2d := RectangleShape2D.new()
	rectangle_shape2d.size = BULLET_SIZE
	
	var collision_shape:= CollisionShape2D.new()
	collision_shape.shape = rectangle_shape2d
	
	return collision_shape

func _init_sprite(texture: Texture2D) -> void:
	var new_sprite := Sprite2D.new()
	new_sprite.texture = texture
	add_child(new_sprite)

func _init_hitbox() -> void:
	var new_hitbox := Hitbox.new()
	new_hitbox.attack_resource = attack_resource
	new_hitbox.add_child(_get_collision_shape())
	new_hitbox.collision_layer = BULLET_COLLISION_LAYER
	new_hitbox.hit.connect(_on_hitbox_hit)
	add_child(new_hitbox)

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(direction * speed * delta)
	
	if collision:
		if bounce:
			direction = direction.bounce(collision.get_normal())
			rotation = direction.angle()
		else:
			_destroy_on_wall_hit()

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= life_time:
		_destroy_on_timeout()

func _destroy_on_timeout() -> void:
	queue_free()

func _on_hitbox_hit(_attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2):
	queue_free()

func _destroy_on_wall_hit() -> void:
	queue_free()
