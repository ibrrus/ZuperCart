local distributionTable = {
    all =
    {
        counter = {
            rolls = 1,
            items = {
                "Jagdkommando", 0.1,
				"JagdkommandoOnCase", 0.1,
				"JagdkommandoCase", 0.1,
            },
        },
    },
	shed =
    {
        other ={
            rolls = 2,
            items = {
                "Jagdkommando", 0.1,
				"JagdkommandoOnCase", 0.1,
				"JagdkommandoCase", 0.1,
            },
        },
	},
	garagestorage =
    {
        other ={
            rolls = 2,
            items = {
                "Jagdkommando", 0.2,
				"JagdkommandoOnCase", 0.2,
				"JagdkommandoCase", 0.2,
            },
        },
	},
	garage =
    {
        metal_shelves ={
            rolls = 2,
            items = {
                "Jagdkommando", 0.3,
				"JagdkommandoOnCase", 0.3,
				"JagdkommandoCase", 0.3,
            },
        },
	},
	toolstore =
    {
        isShop = true,
        shelves ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.2,
				"JagdkommandoOnCase", 0.2,
				"JagdkommandoCase", 0.2,
			},
		},
		counter ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.3,
				"JagdkommandoOnCase", 0.3,
				"JagdkommandoCase", 0.3,
			},
		},
	},
	policestorage = {
        locker ={
            rolls = 4,
            items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
	armystorage = {
        locker ={
            rolls = 2,
            items = {
				"Jagdkommando", 0.7,
				"JagdkommandoOnCase", 0.7,
				"JagdkommandoCase", 0.7,
			},
		},
	},
	gunstore =
    {
        isShop = true,
        displaycase ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.6,
				"JagdkommandoOnCase", 0.6,
				"JagdkommandoCase", 0.6,
			},
		},
		counter ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
		locker ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
		metal_shelves ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
	security = {
        locker ={
            rolls = 3,
            items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
	armysurplus =
    {
        isShop = true,
        shelves ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
		metal_shelves ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
	camping =
    {
        counter ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
		shelves ={
			rolls = 3,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
	campingstorage =
    {
        crate ={
			rolls = 5,
			items = {
				"Jagdkommando", 0.5,
				"JagdkommandoOnCase", 0.5,
				"JagdkommandoCase", 0.5,
			},
		},
	},
}

table.insert(Distributions, distributionTable);