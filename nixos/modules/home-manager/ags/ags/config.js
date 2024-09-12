import { appLauncher } from "./widgets/launcher/appLauncher.js"
import { StatusBar } from "./widgets/statusBar/statusBar.js"

App.config({
    style: "./style.css",
    windows: [
        StatusBar(),
        appLauncher,

        // you can call it, for each monitor
        // Bar(0),
        // Bar(1)
    ],
})

export { }
