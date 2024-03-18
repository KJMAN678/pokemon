# Python 3.11とNode.js 21を含むイメージをベースに使用
FROM nikolaik/python-nodejs:python3.11-nodejs21

# 必要なツールをインストール
RUN apt-get update && apt-get install -y git curl xdg-utils
RUN apt-get install swig cmake libopenmpi-dev zlib1g-dev xvfb x11-utils ffmpeg -qq -y

# アプリケーションディレクトリを作成
WORKDIR /usr/src/app

# pokemon-showdownリポジトリをクローンし、必要な依存関係をインストール
RUN git clone --depth 1 https://github.com/smogon/pokemon-showdown.git 
WORKDIR /usr/src/app/pokemon-showdown
RUN npm install
RUN cp config/config-example.js config/config.js

# PokéLLMon環境の依存関係をインストール
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip --default-timeout=1000 install --no-cache-dir -r requirements.txt

COPY ./app/ /usr/src/app

# アプリケーションがリッスンするポートを指定
EXPOSE 8000
# アプリケーションを起動するコマンド
CMD [ "node", "pokemon-showdown", "start", "--no-security" ]
