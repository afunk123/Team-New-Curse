extends Sprite

var health = 20
var max_health = 20
var attack = 100
var defense = 12
var skip = false

var number = 0
var turn = false
onready var Combat = get_node('/root/Game/Combat')
var actions = ['attack', 'defend']

func _ready():
	randomize()
	position = Vector2(800,100)

func choose_action():
	var odds = int(randf()*3)
	if odds == 0:
		return 'defend'
	else :
		return 'attack'

func take_action():
	var action = choose_action()
	if action == 'attack':
		Global.stats['health'] -= attack/Global.stats['defense']
	elif action == 'defend':
		if defense < Global.stats['attack'] :
			defense += 2
		else:
			Global.stats['health'] -= attack/Global.stats['defense']
			action = 'attack'
			
	print('enemy chose to ' + action)

func damage(d):
	if int(d) == 0:
		d = 1
	health -= int(d)
	if health <= 0:
		Combat.win = true
