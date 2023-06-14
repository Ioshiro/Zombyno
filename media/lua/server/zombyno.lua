Zombyno = {}
function Zombyno.BehaviorNemesis(zombie)
	local timer = Zombyno.CheckTimer(zombie, items)
	if timer == false then return end

	if zombie:getThumpTarget() ~= nil then
		local thump = zombie:getThumpTarget()
		if instanceof(thump, "IsoDoor") then
			thump:destroy()
			zombie:playSound("breakdoor")
			zombie:setAttachedItem("JawStab", InventoryItemFactory.CreateItem("Zombyno.Token_Timer"))
		elseif instanceof(thump, "IsoBarricade") then
				thump:DamageBarricade(100)
		elseif instanceof(thump, "IsoWindow") then
			if thump:getBarricadeForCharacter(zombie) then
				local barricade = thump:getBarricadeForCharacter(zombie)
				barricade:DamageBarricade(100)
			else
				thump:Damage(100, zombie)
				local item = InventoryItemFactory.CreateItem("Zombyno.Token_Timer")
				item:setUsedDelta(0.25)
				zombie:setAttachedItem("JawStab", item)
			end
		elseif instanceof(thump, "IsoThumpable") then
			thump:destroy()
			zombie:setAttachedItem("JawStab", InventoryItemFactory.CreateItem("Zombyno.Token_Timer"))
		elseif instanceof(thump, "BaseVehicle") then

		end
	end
end

function Zombyno.CheckTimer(zombie, items)
    if items and items:size() > 0 then
        for j=0,items:size()-1 do
            local item = items:getItemByIndex(j)
				if item and item:getType() == "Token_Timer" then
					if item:getDrainableUsesInt() == 0 then
						zombie:removeAttachedItem(item)
						return true
					end
					item:Use()
					return false
				else
					return true
			end
		end
	end

end

function Zombyno.LoadZombies()

	local zombies = getPlayer():getCell():getZombieList()
	local cnt1 = zombies:size()-1;
	for i=0,cnt1 do
		local zombie = zombies:get(i);
		Zombyno.ReloadZombie(zombie);
	end
end

function Zombyno.ReloadZombie(zombie)
    local items = zombie:getAttachedItems()     
    if items and items:size() > 0 then
        for j=0,items:size()-1 do
            local item = items:getItemByIndex(j)
			if item and item:getType() == "Token_zombyno" then
				if not isClient() and not isServer() then
					zombie:setOnlyJawStab(true)
					zombie:setHealth(200)
				end
				--zombie:changeSpeed(3)
				--zombie:DoZombieStats()
				zombie:setCanCrawlUnderVehicle(false)
			end
        end
    end
end

function Zombyno.UpdateZombie(zombie)
	local timer = Zombyno.CheckTimer(zombie, items)
	if timer == false then return end
    local items = zombie:getAttachedItems()   
    if items and items:size() > 0 then
        for j=0,items:size()-1 do
            local item = items:getItemByIndex(j)
			if item and item:getType() == "Token_zombyno" then
				if  not isClient() and not isServer() then
					--
				end
				--zombie:setOnlyJawStab(true)
				if zombie:getHealth() < 200 then
					zombie:setHealth(200)
				end
				zombie:setHealth(999)
				--zombie:setImmortalTutorialZombie(true)
				--zombie:setInvincible(true)
				--zombie:setOnFire(true)
				--zombie:setLastHitCount(999)
				--zombie:changeSpeed(1)
				--zombie:DoZombieStats()
				local item = InventoryItemFactory.CreateItem("Zombyno.Token_Timer")
				item:setUsedDelta(0.99)
				zombie:setAttachedItem("JawStab", item)
				Zombyno.BehaviorNemesis(zombie)
			end
        end
    end
end

local function OnWeaponHitCharacter(wielder, character, handWeapon, damage)
	wielder:setOnFire(true)
end

Events.OnWeaponHitCharacter.Add(OnWeaponHitCharacter)


Events.OnZombieUpdate.Add(Zombyno.UpdateZombie)
Events.OnGameStart.Add(Zombyno.LoadZombies);