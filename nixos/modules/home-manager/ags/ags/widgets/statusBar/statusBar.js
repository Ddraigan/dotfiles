import { Workspaces } from "./components/workspaces"
import { Media } from "./components/media"
import { SysTray } from "./components/systray"
import { Clock } from "./components/clock"
import { ClientTitle } from "./components/clientTitle"
import { Notifications } from "./components/notifications"
import { Volume } from "./components/volume"
import { BatteryLabel } from "./components/batteryLabel"

// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            Workspaces(),
            ClientTitle(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
            Media(),
            Notifications(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            Volume(),
            BatteryLabel(),
            Clock(),
            SysTray(),
        ],
    })
}

export function StatusBar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}
