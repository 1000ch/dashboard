# Node.js

## Premise

公式で配布されている`.pkg`からインストールすると色々と面倒臭いので、  
バージョンマネージャーを使う。今回は`nvm`を使用する。  
基本的にREADMEの通り。  

+ [creationix / nvm](https://github.com/creationix/nvm)

## nvmをインストールする

### インストールスクリプトをカールで落として実行

    $ curl https://raw.github.com/creationix/nvm/master/install.sh | sh

ホームディレクトリに`~/.nvm`というフォルダが作成されて、  
インストールしていく`node`はこの中で管理される。  
`nvm`のパスを通すために、`.bashrc`か`.bash_profile`あたりが書き換わっている。  

### ターミナルを再起動

`nvm`コマンドが実行できることを確認する。  

    $ nvm

## nodeをインストールする

インストールしたいバージョンを指定して、インストールする。  

    $ nvm install 0.10.12

`npm`はインストールしたバージョン下の`node_modules`にインストールされる。  
インストールしたnodeが使用されるバージョンになる。  
次に違うバージョンをインストールしてみる。  

    $ nvm install 0.8.25

インストールした`node`はホームディレクトリの`.nvm`配下にバージョンごとに配置される。  
使いたいバージョンを指定する場合は`use`コマンドで指定する。  

    $ nvm use 0.10.12
    $ nvm use 0.8.25