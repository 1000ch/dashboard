# VPS

## Premise

さくらVPSでCentOS 6 x86_64をインストールして、  
sshとかのログイン周りを整理する。  
OSのインストールが完了している状態を前提とします。  

## 初期ログイン

### ssh [hostname]

    ssh [hostname]

`~/.ssh/known_hosts`にVPSをホストとして認識させる。  
失敗する場合はそのホスト名を削除してから再度実行。  

    vim ~/.ssh/known_hosts

対象の`hostname`が記載されている行を削除する。  
これは、ログイン先の公開鍵がhostnameに対して登録済で、  
VPSが発行する公開鍵がknown_hostsに記述されているものと異なるためです。  

## 一般ユーザーの作成

### useradd [username]

一般ユーザーを作成します。  

    useradd [username]

### passwd [username]

指定ユーザーのパスワードを設定します。

    passwd [username]

## ログイン周りの整理

### rootログインの拒否

sshdの設定でrootログインを拒否します。  

    vim /etc/ssh/sshd_config

sshdの設定を記述するsshd_configを編集します。  

    PermitRootLogin no

rootログインを拒否し、保存します。  

    /etc/init.d/sshd restart

sshdデーモンを再起動します。  

