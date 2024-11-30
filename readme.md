# NeMo for TUT cluster system
[NeMo](https://github.com/NVIDIA/NeMo) をTUTクラスタで利用するための設定です．

## xind*ノードのみで追加パッケージなどもない場合
[インストールガイド](https://docs.nvidia.com/nemo-framework/user-guide/latest/installation.html)に従い，`nvcr.io/nvidia/nemo:24.09`をイメージ指定すれば動作します．

しかし，xsnd*ノードではイメージに入っているCUDAとの齟齬が生じるため，動作しません．

## xsnd*ノードの利用，または追加パッケージなどがある場合
このリポジトリの設定が使えます．

# How to use
+ `conda`または`mamba`が使える環境を用意します
+ `nvcr.io/nvidia/pytorch:22.12-py3`を指定した計算サーバにインタラクティブモードで入ります
+ `00install.sh`を実行します（`nemo`環境が作成されます）
+ (Optional) Shallow FusionなどのASR+LMタスクを行う場合は`01install.sh`を実行します
+ 計算サーバから`exit`します

インストールは以上です．

実行時は，`run_example.sh`を参考にしてください．
サンプル実行スクリプトでは，`qcmd`を利用しているため，[Tips](https://hpcportal.imc.tut.ac.jp/wiki/ClusterSystemTips#A.2BMOkwwzDRMPwwxDD8MOswbootW5ow.2B1IpdSg-)を参考に導入してください．