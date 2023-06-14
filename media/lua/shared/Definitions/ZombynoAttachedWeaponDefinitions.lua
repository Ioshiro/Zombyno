require "Definitions/AttachedWeaponDefinitions"

-- zombie tokens
AttachedWeaponDefinitions.zombyno = {
	chance = 100,
	weaponLocation = {"Holster Right"},
	outfit = {"zombyno"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Zombyno.Token_zombyno",
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.zombyno = {
	chance = 100;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.zombyno,
	},
}