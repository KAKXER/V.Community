local labels = {
  ['en'] = {
    ['Entry']       = "khane",
    ['Exit']        = "khoroj",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Lebas",
    ['Inventory']   = "Inventory",
    ['InventoryLocation']   = "Inventory",

    ['LeavingHouse']      = "Leaving house",

    ['AccessHouseMenu']   = "Access the house menu",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "vasile naghliye shoma dar garage park shod",
    ['CantStoreVehicle']  = "shoma nemitavanid in vasile naghliye ra dar garage park konid",

    ['HouseNotOwned']     = "shoma malek in khane nistid",
    ['InvitedInside']     = "davat khane ra bepazirid",
    ['MovedTooFar']       = "shoma az dar fasle darid",
    ['KnockAtDoor']       = "yek nafar darad khane shoma ra mizanad",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "ghofl khane baz ast",
    ['Locked']            = "khane ghofl shod",

    ['WardrobeSet']       = "~g~moghiyat makani lebas shoma set shod.",
    ['InventorySet']      = "~g~moghiyat makani inventory shoma set shod.",

    ['ToggleFurni']       = "Baz Kardam Menu Design",

    ['GivingKeys']        = "dadn kilid be digaran",
    ['TakingKeys']        = "pas gerftan kilid az digaran",

    ['GarageSet']         = "set kardan location garage",
    ['GarageTooFar']      = "Garage khayli door ast",


    ['PurchasedHouse']    = "~g~Khane shoma ba movafaghiyat kharidari shod. ~h~ghimat kharidari shode: $%d",
    ['CantAffordHouse']   = "shoma nemitavanid in khane ra bekharid",

    ['MortgagedHouse']    = "shoma khane ra ba mablagh $%d rahn kardid",

    ['NoLockpick']        = "~y~shoma picklock baraye baz kardan dar khane nadarid",
    ['LockpickFailed']    = "~r~shoma natavanestid ghofl ra beshkanid",
    ['LockpickSuccess']   = "~g~shoma ba movafaghiyat ghofl ra shekastid",

    ['NotifyRobbery']     = "[Police, sheriff, government] dar hale baz kardan dar khane shoma ba hokm vorod hastand ID: %s ",

    ['ProgressLockpicking'] = "Dar hale bastan dar ha",

    ['InvalidShell']        = "~y~shell na motabar ast ID: %s, lotfan be Developer etelaa dahid",
    ['ShellNotLoaded']      = "~y~Shell ba ID: %s bargiri nemishavad, lotfan be Developer etelaa dahid.",
    ['BrokenOffset']        = "~y~khane ba ID %s kharab ast, lotfan be Developer etelaa dahid.",

    ['UpgradeHouse']        = "khane ra be %s ertegha dadid",
    ['CantAffordUpgrade']   = "You can't afford this upgrade",

    ['SetSalePrice']        = "gheymat forosh ra taiin konid",
    ['InvalidAmount']       = "meghdar vard shode namotabar ast",
    ['InvalidSale']         = "shoma nemitavanid in khane ra befroshid zira bedehi darid",
    ['InvalidMoney']        = "~r~shoma pol kafi nadarid",

    ['EvictingTenants']     = "ekhraj mostajeran",

    ['NoOutfits']           = "shoma hich lebasi dar komod nadarid",

    ['EnterHouse']          = "raftan be khane",
    ['KnockHouse']          = "Dar zadan",
    ['RaidHouse']           = "Raid House",
    ['BreakIn']             = "baz kardan dar khone",
    ['InviteInside']        = "Invite Inside",
    ['HouseKeys']           = "Kilid khane",
    ['UpgradeHouse2']       = "ertegha khane",
    ['UpgradeShell']        = "ertegha Shell",
    ['SellHouse']           = "Forosh khane",
    ['FurniUI']             = "Design khane",
    ['SetWardrobe']         = "Set kardan lebas khod",
    ['SetInventory']        = "Set kardan Inventory",
    ['SetGarage']           = "Set Kardan Garage Khane",
    ['LockDoor']            = "Bastan dar",
    ['UnlockDoor']          = "Baz kardan dar",
    ['LeaveHouse']          = "khoroj az khane",
    ['Mortgage']            = "rahn",
    ['Buy']                 = "Kharid",
    ['View']                = "Bazdid",
    ['Upgrades']            = "ertegha",
    ['MoveGarage']          = "raftan be garage",

    ['GiveKeys']            = "dadn kilid be digaran",
    ['TakeKeys']            = "pas gerftan kilid az digaran",

    ['MyHouse']             = "Menu khane",
    ['PlayerHouse']         = "Khane fard",
    ['EmptyHouse']          = "kilid dar khane",

    ['NoUpgrades']          = "No upgrades available",
    ['NoVehicles']          = "No vehicles",
    ['NothingToDisplay']    = "hichi baraye namayesh vojod nadarad",

    ['ConfirmSale']         = "Bale, mikhaham in khone ra be forosh bezaram",
    ['CancelSale']          = "Bkhayr, monsaref shodam",
    ['SellingHouse']        = "forosh khane ($%d)",

    ['MoneyOwed']           = "Money Owed: $%s",
    ['LastRepayment']       = "Last Repayment: %s",
    ['PayMortgage']         = "pardakht vam maskan",
    ['MortgageInfo']        = "etelaat vam maskan",

    ['SetEntry']            = "Set Kardan Vorodi khane",
    ['CancelGarage']        = "set nakardan khone",
    ['UseInterior']         = "Use Interior",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add kardan dar haye jadid",
    ['Done']                = "tamam",
    ['Doors']               = "dar ha",
    ['Interior']            = "dakheli",

    ['CreationComplete']    = "House creation complete.",

    ['HousePurchased'] = "~g~khane shoma kharidari shode ast ~h~be gheymat: $%d",
    ['HouseEarning']   = ", shoma $%d az forosh be dast avardid"
  }
}

Labels = labels[Config.Locale]

