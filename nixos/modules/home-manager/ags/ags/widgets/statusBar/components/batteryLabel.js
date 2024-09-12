const battery = await Service.import("battery")

export function BatteryLabel() {
    const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
    //const icon = battery.bind("percent").as(p =>
    //    `battery-level-${Math.floor(p / 10) * 10}-symbolic`)
    const batIcon = Utils.merge([battery.bind("percent"), battery.bind("charging"), battery.bind("charged")],
        (batPercent: number, batCharging, batCharged) => {
            if (batCharged)
                return `battery-level-100-charged-symbolic`;
            else
                return `battery-level-${Math.floor(batPercent / 10) * 10}${batCharging ? '-charging' : ''}-symbolic`;
        });

    return Widget.Box({
        class_name: "battery",
        visible: battery.bind("available"),
        children: [
            Widget.Icon({
                icon: batIcon
            }),
            Widget.LevelBar({
                widthRequest: 140,
                vpack: "center",
                value,
            }),
        ],
    })
}

