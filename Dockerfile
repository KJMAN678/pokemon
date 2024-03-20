FROM ubuntu:latest

# 必要なツールをインストール
RUN apt update -y
RUN apt upgrade -y
RUN apt-get install -y sudo git curl
RUN apt-get install swig cmake libopenmpi-dev zlib1g-dev xvfb x11-utils ffmpeg -qq -y

# タイムゾーン選択で止まらないようにタイムゾーンを設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Python の関連パッケージをインストール
RUN apt-get install build-essential libbz2-dev libdb-dev \
libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
libncursesw5-dev libsqlite3-dev libssl-dev \
zlib1g-dev uuid-dev tk-dev -y --fix-missing
RUN apt-get install python3-pip -y

# Node.js の関連パッケージをインストール
RUN apt remove --purge nodejs -y
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
RUN apt-get install -y nodejs

# node.js の環境変数を定義する
# 本番環境では production
ENV NODE_ENV=development

# アプリケーションディレクトリを作成
WORKDIR /root/app

# pokemon-showdownリポジトリをクローンし、必要な依存関係をインストール
RUN git clone --depth 1 https://github.com/smogon/pokemon-showdown.git 
WORKDIR /root/app/pokemon-showdown
RUN npm install
RUN cp config/config-example.js config/config.js

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip --default-timeout=1000 install --no-cache-dir -r requirements.txt

COPY ./app/ /root/app

ENV CHOKIDAR_USEPOLLING=true

# アプリケーションがリッスンするポートを指定
EXPOSE 8000
# アプリケーションを起動するコマンド
CMD [ "node", "pokemon-showdown", "start", "--no-security" ]
