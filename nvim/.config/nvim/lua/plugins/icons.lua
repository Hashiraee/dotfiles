local present, icons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

local colors = require("themes/catppuccin")

icons.setup {
    override = {
        html = {
            icon = "",
            color = colors.mauve,
            name = "html"
        },
        css = {
            icon = "",
            color = colors.blue,
            name = "css"
        },
        js = {
            icon = "",
            color = colors.yellow,
            name = "js"
        },
        ts = {
            icon = "ﯤ",
            color = colors.teal,
            name = "ts"
        },
        kt = {
            icon = "󱈙",
            color = colors.peach,
            name = "kt"
        },
        png = {
            icon = "",
            color = colors.mauve,
            name = "png"
        },
        jpg = {
            icon = "",
            color = colors.mauve,
            name = "jpg"
        },
        jpeg = {
            icon = "",
            color = colors.mauve,
            name = "jpeg"
        },
        mp3 = {
            icon = "",
            color = colors.white,
            name = "mp3"
        },
        mp4 = {
            icon = "",
            color = colors.white,
            name = "mp4"
        },
        out = {
            icon = "",
            color = colors.white,
            name = "out"
        },
        Dockerfile = {
            icon = "",
            color = colors.sky,
            name = "Dockerfile"
        },
        rb = {
            icon = "",
            color = colors.pink,
            name = "rb"
        },
        vue = {
            icon = "﵂",
            color = colors.green,
            name = "vue"
        },
        py = {
            icon = "",
            color = colors.sky,
            name = "py"
        },
        toml = {
            icon = "",
            color = colors.blue,
            name = "toml"
        },
        lock = {
            icon = "",
            color = colors.red,
            name = "lock"
        },
        zip = {
            icon = "",
            color = colors.yellow,
            name = "zip"
        },
        xz = {
            icon = "",
            color = colors.yellow,
            name = "xz"
        },
        deb = {
            icon = "",
            color = colors.sky,
            name = "deb"
        },
        rpm = {
            icon = "",
            color = colors.peach,
            name = "rpm"
        },
        lua = {
            icon = "",
            color = colors.blue,
            name = "lua"
        },
    },
}
