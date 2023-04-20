extends Sprite

var health = 50
var max_health = 50
var attack = 50
var atk_up = 10 #increases attack value during atk up punch
var defense = 10

var number = 0
var turn = false
onready var Combat = get_node('/root/Game/Combat')
var actions = ['attack', 'use webs']
var skip = false

func _ready():
	randomize()
	position = Vector2(800,100)

func choose_action():
	var odds = int(randf()*2)
	if odds == 0:
		return 'atk up punch'
	elif odds == 1:
		return 'attack'
	elif odds == 2:
		return 'defend'

func take_action():
	if health > 0 :
		skip = false
		var action = choose_action()
		if action == 'attack':
			Global.stats['health'] -= attack/Global.stats['defense']
		elif action == 'atk up punch':
			Global.stats['health'] -= attack/Global.stats['defense']
			attack += atk_up
		elif action == 'defend':
			defense *= 1.5
			defense = int(defense)
		print('enemy chose to ' + action)

func damage(d):
	if int(d) == 0:
		d = 1
	health -= int(d)
	if health <= 0:
		Combat.win = true
