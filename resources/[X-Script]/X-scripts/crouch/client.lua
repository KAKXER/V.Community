local Crouched = false
local CrouchedForce = false
local Aimed = false
local LastCam = 0
local Cooldown = false
local CoolDownTime = 500
local PlayerID = PlayerId()

local function NormalWalk()
	SetPedMaxMoveBlendRatio(LocalPlayer.state.ped, 1.0)
	ResetPedMovementClipset(LocalPlayer.state.ped, 0.55)
	ResetPedStrafeClipset(LocalPlayer.state.ped)
	SetPedCanPlayAmbientAnims(LocalPlayer.state.ped, true)
	SetPedCanPlayAmbientBaseAnims(LocalPlayer.state.ped, true)
	ResetPedWeaponMovementClipset(LocalPlayer.state.ped)
	Crouched = false
    LocalPlayer.state:set("crouched", Crouched, true)
end

local function SetupCrouch()
	while not HasAnimSetLoaded('move_ped_crouched') do
		Citizen.Wait(5)
		RequestAnimSet('move_ped_crouched')
	end
end

local function RemoveCrouchAnim()
	RemoveAnimDict('move_ped_crouched')
end

local function CanCrouch()
	if ESX.GetPlayerData()['IsDead'] ~= 1 and IsPedOnFoot(LocalPlayer.state.ped) and not IsPedJumping(LocalPlayer.state.ped) and not IsPedFalling(LocalPlayer.state.ped) and not IsPedDeadOrDying(LocalPlayer.state.ped) then
		return true
	else
		return false
	end
end

local function CrouchPlayer()
	SetPedUsingActionMode(LocalPlayer.state.ped, false, -1, "DEFAULT_ACTION")
	SetPedMovementClipset(LocalPlayer.state.ped, 'move_ped_crouched', 0.55)
	SetPedStrafeClipset(LocalPlayer.state.ped, 'move_ped_crouched_strafing')
	SetWeaponAnimationOverride(LocalPlayer.state.ped, "Ballistic")
	Crouched = true
    LocalPlayer.state:set("crouched", Crouched, true)
	Aimed = false
end

local function  SetPlayerAimSpeed()
	SetPedMaxMoveBlendRatio(LocalPlayer.state.ped, 0.2)
	Aimed = true
end

local function IsPlayerFreeAimed()
	if IsPlayerFreeAiming(PlayerID) or IsAimCamActive() or IsAimCamThirdPersonActive() then
		return true
	else
		return false
	end
end

local function CrouchLoop()
	SetupCrouch()
	while CrouchedForce do
		local CanDo = CanCrouch()
		if CanDo and Crouched and IsPlayerFreeAimed() then
			SetPlayerAimSpeed()
		elseif CanDo and (not Crouched or Aimed) then
			CrouchPlayer()
		elseif not CanDo and Crouched then
			CrouchedForce = false
			NormalWalk()
		end

		local NowCam = GetFollowPedCamViewMode()
		if CanDo and Crouched and NowCam == 4 then
			SetFollowPedCamViewMode(LastCam)
		elseif CanDo and Crouched and NowCam ~= 4 then
			LastCam = NowCam
		end

		Citizen.Wait(5)
	end
	NormalWalk()
	RemoveCrouchAnim()
end

AddEventHandler("onKeyDown", function(key)
    DisableControlAction(0, 36, true)
	if key == "lcontrol" and ESX.GetPlayerData()['IsDead'] ~= 1 then
		if CanCrouch() then

            if not Cooldown then
                CrouchedForce = not CrouchedForce
				TriggerServerEvent("esx_idoverhead:AdminTagVanish", GetPlayerServerId(PlayerId()), CrouchedForce)
                if CrouchedForce then
                    CreateThread(CrouchLoop)
                end
    
                Cooldown = true
                SetTimeout(CoolDownTime, function()
                    Cooldown = false
                end)
            end

		end
    end
end)
