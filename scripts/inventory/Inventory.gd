extends Resource

class_name Inventory
const maxSize = 10
@export var items: Array[InvItem]

# Called every frame. 'delta' is the elapsed time since the previous frame.

func FindItem(other_item):
	for item in items:
		if item.name == other_item.name:
			return item
	return null

func AddItem(other_item : InvItem):
#Check slot avalibility
	print("Adding Item")
	if items.size() < maxSize:
		print("Size Check Good")
		var item = FindItem(other_item)
#Check item presence
		if item == null: 
			print("Item does not exist but added")
			items.push_back(other_item)
		else:
			print("Item exists, adding count")
			item.count += other_item.count
			#TODO: add check for item count and max count of item slot

	pass


#Subtracts the first occurance of the items in the inventory 
#and removes it from the inventory if its count is less than 1
func RemoveItem(other_item):
	var item = FindItem(other_item)
	if item != null:
		#Check Item Presence
		item.count -= other_item.count

		#Check if the slot has run out of items or not
		if item.count < 1: 
			items.erase(item)

	return item
