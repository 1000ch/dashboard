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

rootログインを拒否します。  

### sshのポートを変更

同様にsshd_configの設定を変更します。  

    Port [portnumber]

ポート番号を変更して保存します。忘れないように！  

### sshdの再起動

    /etc/init.d/sshd restart

sshdデーモンを再起動し、変更を適用します。  

## ローカルの秘密鍵を利用してログインする設定

今回はVPS用のsshkeyを用意し、設定します。  

### sshkeyを用意

    ssh-keygen -t rsa
    
    Enter file in which to save the key...: hoge_rsa

`-t`で鍵の種類を指定します。  
ここではhoge_rsaという名前のkeyを用意しました。  

### ローカルで用意した公開鍵をVPSに登録する

サーバーにログインし、ホームディレクトリに`.ssh`フォルダを作成します。  

    cd ~
    mkdir .ssh
    chmod 700 .ssh

一旦ログアウトし、ローカルの公開鍵をサーバーにコピーします。  
先程`22`ポートではログイン不可にしてあるので、ポート番号を指定して`scp`する必要があります。  

    scp -P [portnumber] ~/.ssh/hoge_rsa.pub [username]@[hostname]:.

再度サーバーにログインし、コピーした公開鍵を`authorized_keys`に登録します。  

    cat hoge_rsa.pub > ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

ローカルから`scp`した公開鍵を削除します。  

    rm hoge_rsa.pub

sshdを再起動し、変更を適用します。  

    /etc/init.d/sshd restart

ログアウトし、秘密鍵を使用してログインします。  

    ssh -p [portnumber] -i ~/.ssh/hoge_rsa [username]@[hostname]

## ファイアーウォール

### iptablesで最低限のファイアーウォール

iptablesファイルを作成、または編集します。  

    cd /etc/sysconfig
    
    vim iptables

以下が設定のサンプルです。  

    *filter
    -A INPUT -i lo -j ACCEPT
    -A INPUT -s 10.0.0.0/255.0.0.0 -j DROP
    -A INPUT -s 172.16.0.0/255.240.0.0 -j DROP
    -A INPUT -s 192.168.0.0/255.255.0.0 -j DROP
    -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
    -A INPUT -p tcp -m tcp --dport [portnumber] -j ACCEPT
    -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    -A OUTPUT -o lo -j ACCEPT
    COMMIT

保存後、再起動します。  

    /etc/rc.d/init.d/iptables restart

## Webサーバーの設定

### Apacheをインストールする

yumでapacheをインストールします。  
自動で起動するように`chkconfig`も設定します。  

    yum install httpd
    
    chkconfig httpd on

### Apacheの設定をする

apacheの設定ファイルがある場所に移動します。  

    cd /etc/httpd/conf

まず、設定ファイル`httpd.conf`のバックアップを取ります。  

    cp httpd.conf httpd.conf.bk