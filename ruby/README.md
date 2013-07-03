# Ruby

## Premise

ruby-buildとrbenvでグローバルを汚さないように、  
なおかつ複数バージョンが共存出来るようにする。  
基本的にREADMEの通り。  

+ [sstephenson / ruby-build](https://github.com/sstephenson/ruby-build/)
+ [sstephenson / rbenv](https://github.com/sstephenson/rbenv/)

## rbenvをインストールする

### ホームディレクトリにcloneする

    $ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

### cloneしたリソースにパスを通す

`~/.profile`でも`~/.zshrc`でも大丈夫。  
あと、`rbenv init`を通しておく。  

    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    $ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

## ruby-buildをrbenvのプラグインとしてインストールする

### rbenvのpluginsフォルダにcloneする

スタンドアロンインストールしてもいいけど、  
結局rbenvと併用するし、シェルとかも面倒なので。  

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

## rubyをインストールする

ruby-buildのインストールによって、`rbenv install`が出来る。  
インストールしたrubyは`~/.rbenv/versions/`に配置される。  

    rbenv install 1.9.3-p327