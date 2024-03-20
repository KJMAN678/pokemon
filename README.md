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
# ローカル上で pokemon/app の絶対パスを取得し、下記 xxx 部分に貼り付け、コマンドを実行
export LOCAL_APP_PATH=/Users/koji/data/pokemon/app
echo $LOCAL_APP_PATH

# コンテナの作成(1回目のみ)
docker compose build --no-cache

# コンテナの起動
docker compose up -d

# VSCode の拡張機能 dev containers 経由で開発コンテナ(pokemon-pokemon-showdown-1)に入る

# コンテナの停止
docker compose down
```
node pokemon-showdown/pokemon-showdown

docker exec -it pokemon-pokemon-showdown-1 /bin/bash
