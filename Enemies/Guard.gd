extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var killed = false

onready var Combat = get_node('/root/Game/Combat')

func _ready():
	direction = Vector2.LEFT

func _physics_process(_delta):
	if Combat.visible == false:
		if velocity.x > 0 and !$Sprite.flip_h:
			$Sprite.flip_h = true
		if velocity.x <= 0 and $Sprite.flip_h :
			$Sprite.flip_h = false
		velocity = speed * direction
		velocity = move_and_slide(velocity, Vector2.UP)

func change_direction() :
	direction *= -1
		
func _on_Timer_timeout():
	change_direction()	

func die():
	killed = true
	queue_free()


func _on_Combat_Start_body_entered(body):
	if body.name == 'Player' and Combat.visible == false:
		#Global.combats_completed[Global.room]=true
		Combat.show()
