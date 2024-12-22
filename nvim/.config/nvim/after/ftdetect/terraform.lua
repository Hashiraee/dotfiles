vim.filetype.add({
    extension = {
        tf = "terraform",
        tfvars = "terraform",
        hcl = "hcl",
    },
    pattern = {
        -- Detect terraform configuration files
        [".*/%.terraform/.*%.tf$"] = "terraform",

        -- Detect terraform state files as json
        ["terraform%.tfstate.*"] = "json",

        -- Detect terraform variable files
        [".*%.tfvars$"] = "terraform",

        -- Detect terraform override files
        [".*%.tfvars%.json$"] = "terraform",
    }
})
