extends Sprite

var health = 30
var max_health = 30
var attack = 100
var defense = 10
var skip = false
var ddrop = 3 #deteremines what to drop player defense by when ddrop action taken
var bloodsuck = 3 #drains player health by 3 and raises own health by 3
var number = 0
var turn = false
onready var Combat = get_node('/root/Game/Combat')
var actions = ['attack', 'defend']

func _ready():
	randomize()
	position = Vector2(800,100)

func choose_action():
	var odds = int(randf()*4)
	if odds == 0:
		return 'defend'
	if odds == 1:
		return 'attack'
	if odds == 2:
		return 'drop your defense'
	if odds <= 3:
		return 'suck your blood'

func take_action():
	var action = choose_action()
	if action == 'attack':
		Global.stats['health'] -= attack/Global.stats['defense']
	elif action == 'defend':
		if defense < Global.stats['attack'] :
			defense += 1
			defense = int(defense)
		else:
			Global.stats['health'] -= attack/Global.stats['defense']
			action = 'attack'
	elif action == 'drop your defense' :
		if Global.stats['defense'] >= 1 + ddrop:
			Global.stats['defense'] -= ddrop
	elif action == 'suck your blood' :
		Global.stats['health'] -= bloodsuck
		health += bloodsuck
	Global.enemy_text = 'enemy chose to ' + action

func damage(d):
	if int(d) == 0:
		d = 1
	health -= int(d)
	if health <= 0:
		Combat.win = true
