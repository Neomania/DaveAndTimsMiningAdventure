extends Node2D

@export var mineableTemplate: PackedScene
@export var genWidth: float = 1920
@export var genHeight: float = 1080
@export var genMaxRadius: float = 128
@export var genMinRadius: float = 64
@export var genCount: int = 5
@export var valueScaleFactor: float = 0.1

class MineablePoint:
	var radius: float
	var position: Vector2
	
	func _init(r: float, p: Vector2):
		radius = r
		position = p
		
func _ready():
	var results: Array[MineablePoint] = attemptCreateMineables(genWidth, genHeight, genMaxRadius, genMinRadius, genCount)
	if (results == null):
		print("Failed to generate points")
	
	for mineable in results:
		generateMineable(mineable)

func generateMineable(point: MineablePoint):
	var newMineable: RigidBody2D = mineableTemplate.instantiate()
	var points: PackedVector2Array = generatePolygon(randi_range(4, 8), point.radius)
	var value = point.radius ** 2
	print(point.position)
	newMineable.get_node("CollisionPolygon2D").set_polygon(points)
	newMineable.set_global_position(point.position)
	print(newMineable.global_position)
	newMineable.resourceValue = value * valueScaleFactor
	
	add_child(newMineable)
	
func generatePolygon(vertices: int, maxRadius: float):
	var newPolygon = PackedVector2Array()
	var angleInterval = TAU / vertices
	
	for i in range(vertices):
		var radius = randf_range(maxRadius - maxRadius / 5, maxRadius)
		newPolygon.append(Vector2(radius * cos(angleInterval * i), radius * sin(angleInterval * i)))
	
	return newPolygon
		

func attemptCreateMineables(
	width: float,
	height: float,
	maxRadius: float,
	minRadius: float,
	count: int):
	for j in range(count, 0, -1):
		for i in range(10):
			var result = attempt(width, height, maxRadius, minRadius, j)
			if result != null:
				return result
		print("Could not position %d mineables after 10 attempts. Retrying with %d mineables." % [j, j - 1])
	
	return null


func attempt(
	width: float,
	height: float,
	maxRadius: float,
	minRadius: float,
	count: int):
	# Try finding count points
	var potentialPoints: Array[MineablePoint] = []
	
	for i in range(count):
		var newRadius = randf_range(minRadius, maxRadius)
		var newPosition = Vector2(randf_range(newRadius, width - newRadius), randf_range(newRadius, height - newRadius))
		for j in range(potentialPoints.size()):
			var radiusSquared = (newRadius + potentialPoints[j].radius) ** 2
			if (potentialPoints[j].position.distance_squared_to(newPosition) < radiusSquared):
				# abort
				return null
				
		potentialPoints.append(MineablePoint.new(newRadius, newPosition))
	
	return potentialPoints
