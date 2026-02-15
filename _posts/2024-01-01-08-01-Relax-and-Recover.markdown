---
layout: post
title: Relax-and-Recover
category: "バックアップリストア"
---

Relax-and-Recoverを用いて、RedHat系Linuxサーバーのバックアップ・リストアをする。

# 何ができるか？

- 構築したLinux環境のバックアップ、リストア
    - ディザスタリカバリー
- 削除したファイルの復元
- リラックス

# 想定環境

- RedHat系Linux
- バックアップ・リストア対象サーバー(192.168.100.1)
    - Relax-and-Recoverをインストール
- バックアップ保管用NFSサーバー(192.168.100.2)
    - 公開ディレクトリは/nfs
    - 192.168.100.0/24からのアクセスを許可

# NFS Serverの構築:192.168.100.2

NFSサーバーを構築する。

```sh
dnf -y update
dnf -y install nfs-utils firewalld

nfs_dir=/nfs
mkdir -p ${nfs_dir}
echo "${nfs_dir} 192.168.100.0/24(rw,no_root_squash)" > /etc/exports
# echo "${nfs_dir} *(rw,no_root_squash)" > /etc/exports

exportfs -ra

systemctl enable --now rpcbind nfs-server firewalld
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload
```

# Relax-and-Recoverインストール:192.168.100.1

```sh
dnf -y update
dnf -y install rear grub2-efi-x64-modules

# EFIの場合追加でインストール(for grub2-mkstandalone command)
dnf -y install grub2-tools-extra
```

## Relax-and-Recoverコンフィグ

```sh
cp /etc/rear/local.conf /etc/rear/local.conf.bak
cat <<'EOF' > /etc/rear/local.conf
OUTPUT=ISO
BACKUP=NETFS
BACKUP_URL="nfs://192.168.100.2/nfs/"

BACKUP_PROG_EXCLUDE=("${BACKUP_PROG_EXCLUDE[@]}" '/media' '/var/tmp' '/var/crash' '/kdump')
LOGFILE="$LOG_DIR/rear-$HOSTNAME.log"
GRUB_RESCUE=1
EOF

# EFIの場合以下追加
echo 'USING_UEFI_BOOTLOADER=1' >> /etc/rear/local.conf
```

## 設定項目

- **OUTPUT**  
  レスキューシステムの出力形式

- **BACKUP**  
  tarアーカイブの作成に使用できるバックアップ方式

- **BACKUP_URL**  
  tar.gzのバックアップファイルの出力先

/media、/var/tmp、/var/crash、/kdumpは、バックアップ対象から外す。
