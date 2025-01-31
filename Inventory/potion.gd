extends Resource

class_name Potion

@export var id : int
@export var name : String
@export var image : AtlasTexture
@export var price : int

func _init(_id: int = -1, _name: String = "", _image: AtlasTexture = null, _price: int = -1) -> void:
	self.id = _id
	self.name = _name
	self.image = _image
	self.price = _price
