Config = {}

Config.Job = {
    label = 'Realtor',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Trainee',
            payment = 200
        },
        ['1'] = {
            name = 'Realtor',
            payment = 350
        },
        ['2'] = {
            name = 'Manager',
            pay = 500
        },
        ['3'] = {
            name = 'Owner',
            pay = 750
        }
    }
}

Config.Commisions = {
    ['0'] = 0.05, -- 5% commision for each sale
    ['1'] = 0.10,
    ['2'] = 0.15,
    ['3'] = 0.20,
}

Config.RealtorPerms = {
    manageProperty = 1, --minimum grade to manage property | default 1
    changePropertyForSale = 0, --minimum grade to list property | default 0
    sellProperty = 0, --minimum grade to sell property | default 0
    listNewProperty = 2, --minimum grade to list property | default 2
    deleteProperty = 2, --minimum grade to delete property | default 2
}