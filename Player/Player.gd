extends KinematicBody2D
var speed = 200
var max_speed = 200
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var in_combat = false
func _ready():
	global_position = Global.spawn_position
	
func _physics_process(_delta):
	if not in_combat :
		direction = Vector2.ZERO
		if Input.is_action_pressed('up'):
			direction += Vector2.UP
		if Input.is_action_pressed('down'):
			direction += Vector2.DOWN
		if Input.is_action_pressed('left'):
			direction += Vector2.LEFT
		if Input.is_action_pressed('right'):
			direction += Vector2.RIGHT
		velocity = speed * direction
		velocity.x = clamp(velocity.x,-max_speed,max_speed)
		velocity.y = clamp(velocity.y,-max_speed,max_speed)
		velocity = move_and_slide(velocity, Vector2.UP)

