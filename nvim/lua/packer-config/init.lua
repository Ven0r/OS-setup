return require'packer'.startup(function()
    use 'wbthomason/packer.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}
end)
