extends Resource

class_name Supplier

@export var id : int
@export var name : String
@export var image : Texture
@export var unlock_price : int
@export var offer : Offer

func _init(_id: int = -1, _name: String = "", _image: AtlasTexture = null, _unlock_price: int = -1, _offer : Offer = null) -> void:
	self.id = _id
	self.name = _name
	self.image = _image
	self.unlock_price = _unlock_price
	self.offer = _offer
