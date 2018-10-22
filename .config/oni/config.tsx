import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "oni.loadInitVim": true,
    "oni.useDefaultConfig": false,
    "editor.fontSize": "15px",
    "editor.fontFamily": "Iosevka",

    "autoClosingPairs.enabled": false,

    // UI customizations
    "ui.colorscheme": "n/a",
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",

    "oni.hideMenu": true,
    "sidebar.enabled": false,
}
