#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/kerakelv/Tools/main/kerakelv.sh | bash
echo "-----------------------------------------------------------------------------"
echo "Начинаем обновление репрозитория "
echo "-----------------------------------------------------------------------------"
cd $HOME/pathfinder/py
git fetch
git checkout v0.3.7
echo "Репозиторий успешно обновлен, начинаем билд"
echo "-----------------------------------------------------------------------------"
rm -rf $HOME/pathfinder/py/.venv
python3 -m venv .venv
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
rustup default stable
rustup update
cargo build --release --bin pathfinder
sleep 2
source $HOME/.bash_profile &>/dev/null
echo "Билд завершен успешно"
echo "-----------------------------------------------------------------------------"
sudo systemctl restart starknet
echo "Нода обновлена и запущена"
echo "-----------------------------------------------------------------------------"
