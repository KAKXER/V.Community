--[[---------------------------------------------------------------------------------------

	LSPD
	Created by WolfKnight
	
	For discussions, information on future updates, and more, join 
	my Discord: https://discord.gg/fD4e6WD 
	
	MIT License

	Copyright (c) 2020-2021 WolfKnight

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

---------------------------------------------------------------------------------------]]--

--[[----------------------------------------------------------------------------------
	Sync server events
----------------------------------------------------------------------------------]]--
RegisterNetEvent( "policeradar_sync:sendPowerState" )
AddEventHandler( "policeradar_sync:sendPowerState", function( target, state )
	TriggerClientEvent( "policeradar_sync:receivePowerState", target, state )
end )

RegisterNetEvent( "policeradar_sync:sendAntennaPowerState" )
AddEventHandler( "policeradar_sync:sendAntennaPowerState", function( target, state, ant )
	TriggerClientEvent( "policeradar_sync:receiveAntennaPowerState", target, state, ant )
end )

RegisterNetEvent( "policeradar_sync:sendAntennaMode" )
AddEventHandler( "policeradar_sync:sendAntennaMode", function( target, ant, mode )
	TriggerClientEvent( "policeradar_sync:receiveAntennaMode", target, ant, mode )
end )

RegisterNetEvent( "policeradar_sync:sendLockAntennaSpeed" )
AddEventHandler( "policeradar_sync:sendLockAntennaSpeed", function( target, ant, data )
	TriggerClientEvent( "policeradar_sync:receiveLockAntennaSpeed", target, ant, data )
end )

RegisterNetEvent( "policeradar_sync:sendLockCameraPlate" )
AddEventHandler( "policeradar_sync:sendLockCameraPlate", function( target, cam, data )
	TriggerClientEvent( "policeradar_sync:receiveLockCameraPlate", target, cam, data )
end )


--[[----------------------------------------------------------------------------------
	Radar data sync server events
----------------------------------------------------------------------------------]]--
RegisterNetEvent( "policeradar_sync:requestRadarData" )
AddEventHandler( "policeradar_sync:requestRadarData", function( target )
	TriggerClientEvent( "policeradar_sync:getRadarDataFromDriver", target, source )
end )

RegisterNetEvent( "policeradar_sync:sendRadarDataForPassenger" )
AddEventHandler( "policeradar_sync:sendRadarDataForPassenger", function( playerFor, data )
	TriggerClientEvent( "policeradar_sync:receiveRadarData", playerFor, data )
end )

RegisterNetEvent( "policeradar_sync:sendUpdatedOMData" )
AddEventHandler( "policeradar_sync:sendUpdatedOMData", function( playerFor, data )
	TriggerClientEvent( "policeradar_sync:receiveUpdatedOMData", playerFor, data )
end )