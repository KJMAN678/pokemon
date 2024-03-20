### ゲーム + 強化学習 + 量子コンピュータ

- poke-env
- gym-super-mario-bros

### 開発環境

- Silicon Mac
- Python 3.11
- nodejs 21
- Docker Desktop

### コマンド

```sh
# コンテナの作成(1回目のみ)
docker compose build --no-cache

# コンテナの起動
docker compose up -d

# コンテナ名 (pokemon-pokemon-showdown-1) の確認
docker-compose ps

# VSCode で開発コンテナ(pokemon-pokemon-showdown-1)に入る

# カーネルの作成
python3 -m ipykernel install --user --name pokemon

# ポケモンローカルサーバーのURL
http://localhost:8000/


# コンテナから出る
exit
```
