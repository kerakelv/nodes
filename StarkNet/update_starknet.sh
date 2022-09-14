#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/kerakelv/Tools/main/kerakelv.sh | bash
echo "-----------------------------------------------------------------------------"
echo "Починаємо оновлення репрозиторію "
echo "-----------------------------------------------------------------------------"
cd $HOME/pathfinder/py
git fetch
git checkout v0.3.4
echo "Репозиторій успішно оновлено, починаємо білд"
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
echo "Білд завершено успішно"
echo "-----------------------------------------------------------------------------"
systemctl restart starknet
echo "Нода оновлена та запущена"
echo "-----------------------------------------------------------------------------"
