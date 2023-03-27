#!/bin/sh

echo 'Setup Neovim...'

# 依存関係のインストール
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y neovim git curl

# 設定ファイルのディレクトリを作成
mkdir -p ~/.config/nvim

# Gitリポジトリをクローン
echo "Cloning Neovim configuration repository..."
git clone https://github.com/genokamura/neovim-config.git /tmp/nvim_config

# Neovimの設定ファイルをコピー
echo "Copying configuration files..."
cp -R /tmp/nvim_config/nvim_config/* ~/.config/nvim

# vim-plugのインストール
echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovimのプラグインをインストール
echo "Installing plugins..."
nvim +PlugInstall +qall

echo "Neovim setup complete!"

