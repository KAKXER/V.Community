Config.Weapons = {
	{
		name = 'WEAPON_KNIFE',
		label = _U('weapon_knife'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_NIGHTSTICK',
		label = _U('weapon_nightstick'),
		components = {},
		ammo = 'melee',
		weight = 1,
		index = 4
	},

	{
		name = 'WEAPON_HAMMER',
		label = _U('weapon_hammer'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_BAT',
		label = _U('weapon_bat'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_GOLFCLUB',
		label = _U('weapon_golfclub'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_CROWBAR',
		label = _U('weapon_crowbar'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_PISTOL',
		label = _U('weapon_pistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02') }
		},
		ammo = '25_acp',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = _U('weapon_combatpistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '9mm',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_APPISTOL',
		label = _U('weapon_appistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_PISTOL50',
		label = _U('weapon_pistol50'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') }
		},
		ammo = '44_magnum',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_REVOLVER',
		label = _U('weapon_revolver'),
		components = {},
		ammo = '44_magnum',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'weapon_pistol_mk2',
		label = _U('weapon_pistol_mk2'),
		components = {},
		ammo = '25_acp',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'weapon_snspistol_mk2',
		label = _U('weapon_snspistol_mk2'),
		components = {},
		ammo = '25_acp',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'weapon_revolver_mk2',
		label = _U('weapon_revolver_mk2'),
		components = {},
		ammo = '44_magnum',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'weapon_smg_mk2',
		label = _U('weapon_smg_mk2'),
		components = {},
		ammo = '45_acp',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'weapon_pumpshotgun_mk2',
		label = _U('weapon_pumpshotgun_mk2'),
		components = {},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_assaultrifle_mk2',
		label = _U('weapon_assaultrifle_mk2'),
		components = {},
		ammo = '7.62mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_carbinerifle_mk2',
		label = _U('weapon_carbinerifle_mk2'),
		components = {},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_specialcarbine_mk2',
		label = _U('weapon_specialcarbine_mk2'),
		components = {},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_bullpuprifle_mk2',
		label = _U('weapon_bullpuprifle_mk2'),
		components = {},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_combatmg_mk2',
		label = _U('weapon_combatmg_mk2'),
		components = {},
		ammo = '54r',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'weapon_heavysniper_mk2',
		label = _U('weapon_heavysniper_mk2'),
		components = {},
		ammo = '50mm_bmg',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'weapon_marksmanrifle_mk2',
		label = _U('weapon_marksmanrifle_mk2'),
		components = {},
		ammo = '50mm_bmg',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = _U('weapon_snspistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02') }
		},
		ammo = '25_acp',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = _U('weapon_heavypistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '9mm',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = _U('weapon_vintagepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '9mm',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_MICROSMG',
		label = _U('weapon_microsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') }
		},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'WEAPON_SMG',
		label = _U('weapon_smg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '45_acp',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = _U('weapon_assaultsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'WEAPON_MINISMG',
		label = _U('weapon_minismg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02') }
		},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = _U('weapon_machinepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 5,
		index = 3
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = _U('weapon_combatpdw'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') }
		},
		ammo = '45_acp',
		maxAmmo = 250,
		weight = 10,
		index = 3
	},

	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = _U('weapon_pumpshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP') }
		},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = _U('weapon_sawnoffshotgun'),
		components = {
		},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = _U('weapon_assaultshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = _U('weapon_bullpupshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = _U('weapon_heavyshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = _U('weapon_assaultrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '7.62mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = _U('weapon_carbinerifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02') },
			{ name = 'clip_box', label = _U('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = _U('weapon_advancedrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = _U('weapon_specialcarbine'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = _U('weapon_bullpuprifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = _U('weapon_compactrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03') }
		},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_MG',
		label = _U('weapon_mg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02') }
		},
		ammo = '54r',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'WEAPON_COMBATMG',
		label = _U('weapon_combatmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '54r',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = _U('weapon_gusenberg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02') },
		},
		ammo = '54r',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = _U('weapon_sniperrifle'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') }
		},
		ammo = '50mm_bmg',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = _U('weapon_heavysniper'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') }
		},
		ammo = '50mm_bmg',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = _U('weapon_marksmanrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		},
		ammo = '50mm_bmg',
		maxAmmo = 250,
		weight = 20,
		index = 1
	},

	-- Cayo Perico
	{
		name = 'WEAPON_MILITARYRIFLE',
		label = 'Military Rifle',
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MILITARYRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MILITARYRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') }
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_COMBATSHOTGUN',
		label = 'Combat Shotgun',
		components = {},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_GADGETPISTOL',
		label = 'Gadget Pistol',
		components = {},
		ammo = '32_acp',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},
	-- End of cayo perico

	-- Contract DLC
	{
		name = 'WEAPON_HEAVYRIFLE',
		label = 'Heavy Rifle',
		components = {
		},
		ammo = '5.56mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_STUNGUN_MP',
		label = _U('weapon_stungun'),
		components = {},
		ammo = 'melee',
		weight = 1,
		index = 3
	},

	{
		name = 'WEAPON_EMPLAUNCHER',
		label = "Emp Launcher",
		components = {},
		ammo = 'melee',
		weight = 1,
		index = 3
	},

	{
		name = 'WEAPON_HAZARDCAN',
		label =  "Hazard Can",
		components = {},
		ammo = 'melee',
		eammo = true,
		weight = 5,
		index = 4
	},

	{
		name = 'WEAPON_FERTILIZERCAN',
		label = "Fertilizer Can",
		components = {},
		ammo = 'melee',
		eammo = true,
		weight = 5,
		index = 4
	},
	-- END OF contract DLC

	{
		name = 'WEAPON_GRENADELAUNCHER',
		label = _U('weapon_grenadelauncher'),
		components = {},
		ammo = 'grenade',
		maxAmmo = 250,
		weight = 25,
		index = 1
	},

	{
		name = 'WEAPON_GRENADELAUNCHER_SMOKE',
		label = _U('weapon_grenadelauncher_smoke'),
		components = {},
		ammo = 'grenade',
		maxAmmo = 250,
		weight = 25,
		index = 1
	},

	{
		name = 'WEAPON_RPG',
		label = _U('weapon_rpg'),
		components = {},
		ammo = 'rocket',
		maxAmmo = 250,
		weight = 50,
		index = 1
	},

	{
		name = 'WEAPON_MINIGUN',
		label = _U('weapon_minigun'),
		components = {},
		ammo = '54r',
		maxAmmo = 250,
		weight = 50,
		index = 1
	},

	{
		name = 'WEAPON_GRENADE',
		label = _U('weapon_grenade'),
		components = {},
		ammo = 'melee',
		weight = 2.5,
		index = 4
	},

	{
		name = 'WEAPON_STICKYBOMB',
		label = _U('weapon_stickybomb'),
		components = {},
		ammo = 'melee',
		weight = 2.5,
		index = 4
	},

	{
		name = 'WEAPON_SMOKEGRENADE',
		label = _U('weapon_smokegrenade'),
		components = {},
		ammo = 'melee',
		weight = 2.5,
		index = 4
	},

	{
		name = 'WEAPON_BZGAS',
		label = _U('weapon_bzgas'),
		components = {},
		ammo = 'melee',
		weight = 2.5,
		index = 4
	},

	{
		name = 'WEAPON_MOLOTOV',
		label = _U('weapon_molotov'),
		components = {},
		ammo = 'melee',
		weight = 2.5,
		index = 4
	},

	{
		name = 'WEAPON_FIREEXTINGUISHER',
		label = _U('weapon_fireextinguisher'),
		components = {},
		ammo = 'melee',
		eammo = true,
		weight = 3,
		index = 4
	},

	{
		name = 'WEAPON_PETROLCAN',
		label = _U('weapon_petrolcan'),
		components = {},
		ammo = 'melee',
		eammo = true,
		weight = 5,
		index = 4
	},

	{
		name = 'WEAPON_BALL',
		label = _U('weapon_ball'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_BOTTLE',
		label = _U('weapon_bottle'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_DAGGER',
		label = _U('weapon_dagger'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_FIREWORK',
		label = _U('weapon_firework'),
		components = {},
		ammo = 'rocket',
		maxAmmo = 250,
		weight = 5,
		index = 1
	},

	{
		name = 'WEAPON_MUSKET',
		label = _U('weapon_musket'),
		components = {},
		ammo = '7.62mm',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_STUNGUN',
		label = _U('weapon_stungun'),
		components = {},
		ammo = 'melee',
		weight = 1,
		index = 3
	},

	{
		name = 'WEAPON_HOMINGLAUNCHER',
		label = _U('weapon_hominglauncher'),
		components = {},
		ammo = 'rocket',
		maxAmmo = 250,
		weight = 50,
		index = 1
	},

	{
		name = 'WEAPON_PROXMINE',
		label = _U('weapon_proxmine'),
		components = {},
		ammo = 'melee',
		weight = 5,
		index = 4
	},

	{
		name = 'WEAPON_SNOWBALL',
		label = _U('weapon_snowball'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_FLAREGUN',
		label = _U('weapon_flaregun'),
		components = {},
		ammo = 'grenade',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_MARKSMANPISTOL',
		label = _U('weapon_marksmanpistol'),
		components = {},
		ammo = '44_magnum',
		maxAmmo = 250,
		weight = 5,
		index = 1
	},

	{
		name = 'WEAPON_KNUCKLE',
		label = _U('weapon_knuckle'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_HATCHET',
		label = _U('weapon_hatchet'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_RAILGUN',
		label = _U('weapon_railgun'),
		components = {},
		ammo = '54r',
		maxAmmo = 250,
		weight = 30,
		index = 1
	},

	{
		name = 'WEAPON_MACHETE',
		label = _U('weapon_machete'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_SWITCHBLADE',
		label = _U('weapon_switchblade'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_DBSHOTGUN',
		label = _U('weapon_dbshotgun'),
		components = {},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 7.5,
		index = 1
	},

	{
		name = 'WEAPON_AUTOSHOTGUN',
		label = _U('weapon_autoshotgun'),
		components = {},
		ammo = '12_gauge',
		maxAmmo = 250,
		weight = 10,
		index = 1
	},

	{
		name = 'WEAPON_BATTLEAXE',
		label = _U('weapon_battleaxe'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_COMPACTLAUNCHER',
		label = _U('weapon_compactlauncher'),
		components = {},
		ammo = 'grenade',
		maxAmmo = 250,
		weight = 5,
		index = 2
	},

	{
		name = 'WEAPON_PIPEBOMB',
		label = _U('weapon_pipebomb'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_POOLCUE',
		label = _U('weapon_poolcue'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_WRENCH',
		label = _U('weapon_wrench'),
		components = {},
		ammo = 'melee',
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_FLASHLIGHT',
		label = _U('weapon_flashlight'),
		components = {},
		ammo = 'melee',
		weight = 1,
		index = 4
	},

	{
		name = 'GADGET_PARACHUTE',
		label = _U('gadget_parachute'),
		components = {},
		ammo = 'melee',
		gadget = true,
		weight = 5,
		index = 4
	},

	{
		name = 'WEAPON_FLARE',
		label = _U('weapon_flare'),
		components = {},
		ammo = 'grenade',
		maxAmmo = 250,
		weight = 2,
		index = 4
	},

	{
		name = 'WEAPON_DOUBLEACTION',
		label = _U('weapon_doubleaction'),
		components = {},
		ammo = '44_magnum',
		maxAmmo = 250,
		weight = 5,
		index = 2
	}
}

for _, data in ipairs(Config.Weapons) do
	ESX.Items[string.lower(data.name)] = {type = 'item_weapon', name = string.lower(data.name), label = data.label, weight = data.weight, unique = true, usable = false, eligableIndex = data.index, ammo = data.ammo, maxAmmo = data.maxAmmo, components = data.components}
end