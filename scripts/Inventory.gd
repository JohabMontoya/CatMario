extends Node


signal item_added(item_type: Item.ItemType, quantity: int)
signal item_consumed(item_type: Item.ItemType, quantity: int)

var inventory := {}

func add_item_to_inventory(item: Item) -> void:
	if not inventory.has(item.type):
		inventory[item.type] = {
			"quantity": 1,
			"texture": item.get_texture()
		}
	else:
		inventory[item.type]["quantity"] += 1

	var quantity = inventory[item.type]["quantity"]
	#var texture = inventory[item.type]["texture"]

	item_added.emit(item,quantity)

	print("objeto agregado al inventario de tipo ",
		Item.ItemType.keys()[item.type],
		" hay: ",
		quantity
	)


func consume_item_inventory(item_type: Item.ItemType):
	if inventory.has(item_type):
		inventory[item_type]["quantity"] -= 1

	var quantity_left = inventory[item_type]["quantity"]
	item_consumed.emit(item_type,quantity_left)

	print("Se consumio ",
		Item.ItemType.keys()[item_type],
		" quedan: ",
		quantity_left
	)

	if(quantity_left <= 0):
		inventory.erase(item_type)


func get_items() -> Dictionary:
	return inventory

func erase_items():
	inventory.clear()
