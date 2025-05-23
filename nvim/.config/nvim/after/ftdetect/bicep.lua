vim.filetype.add({
    extension = {
        bicep = 'bicep',
        bicepparam = 'bicep',
    },
    pattern = {
        ['.*%.bicep$'] = 'bicep',
        ['.*%.bicepparam$'] = 'bicep',
    },
})
