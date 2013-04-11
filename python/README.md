#Python

##Premise

Macのシステム標準のPython2.7を利用したPythonの実行環境を用意する。  
最新版(Python3.3.1とか)でも、もちろん同様の手順で作成可能。  
仮想化のため、`virtualenv`と`source ./bin/activate`で実行。  

##distributeをインストールする

+ [python-distribute.org](http://python-distribute.org/)

`curl`でダウンロードし、pythonから実行する。  
`easy_install`が実行出来るかどうかを確認する。  

    curl -O http://python-distribute.org/distribute_setup.py
    
    python ./distribute_setup.py
    
    easy_install --help

##virtualenvをインストールする

+ [virtualenv.org](http://www.virtualenv.org/)

`easy_install`からvirtualenvをインストールする。  

    easy_install virtualenv

##pipをインストールする

+ [pip](http://www.pip-installer.org/)

pipはPythonのパッケージをインストールしてくれる。  

>The easiest way to install and use pip is with virtualenv,  
>since every virtualenv has pip (and it’s dependencies) installed into it automatically.  
>When used in this manner, pip will only affect the active virtual environment.  

ということで、virtualenvで環境を別途用意して、アクティベート。  
その後に別途欲しいパッケージなどpipを使ってインストールする。  

pipがなかったらインストールする。

    easy_install pip

##virtualenvを使ってpythonの環境を作成する

デフォルトでインストールされているpythonを使う。  
この場合、`/System/Library/Frameworks/Python.framework`あたりを参照。  

    mkdir pythonenv
    
    virtualenv --distribute pythonenv --python python2.7
    
    source ./pythonenv/bin/activate

pkgからインストールしたpythonを使う。  

    mkdir pythonenv
    
    virtualenv --distribute pythonenv --python python3.3
    
    source ./pythonenv/bin/activate

この場合だと、`/Library/Frameworks/Python.framework`配下のpythonを使う。  