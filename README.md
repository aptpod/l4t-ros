# L4T ROS コンテナイメージ

L4T ROSコンテナイメージは、NVIDIA GPUに対応したROS（Robot Operating System）コンテナイメージです。Ubuntuイメージをベースに、NVIDIA Container Runtimeを用いてNVIDIA GPU対応を実現し、ROSディストリビューションを組み込んだコンテナイメージを提供します。

## 必要条件

このイメージを作成するためには以下のツールが必要です。

- Docker
- podman

## L4Tベースイメージ作成

1. 任意のバージョンのUbuntuイメージをベースにします。
1. NVIDIA Container Runtimeに必要なツールをインストールします。

以下のコマンドを実行してイメージを作成します。

```bash
sudo make UBUNTU_DISTRIB=jammy image
```

| 変数 | 値 |
| ---- | ----- |
| UBUNTU_DISTRIB | jammy, focal, bionic (default: jammy) |

## L4T ROSコンテナイメージ作成

1. L4TベースイメージにROSディストリビューションをインストールします。
1. NVIDIA GPUに対応したROSコンテナを作成します。

以下の手順で実行します：
- 作成したいROSディストリビューションのディレクトリに移動します。
- 次のコマンドを実行します。

```bash
make image
```

| ROS Distro | Directory |
| ---------- | --------- |
| ROS2 Humble | ros/humble |
| ROS2 Foxy | ros/foxy |
| ROS Noetic | ros/noetic |
| ROS Melodic | ros/melodic |


## Usage

コンテナを実行するためのコマンド例は以下の通りです。GPUとGUIオプションを含めることができます。

```bash
xhost +local:
docker run -it --rm \
    --net=host \
    --runtime=nvidia \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    reg.aptpod.io/intdash-robotics/l4t-ros/l4t-ros:humble-desktop-r32.7 \
    /bin/bash
```

## 謝辞とライセンス

このプロジェクトは、以下のリソースの内容をApache License 2.0に準拠して利用しています。

- NVIDIA L4T Base Container Images: [NVIDIA GitLab](https://gitlab.com/nvidia/container-images/l4t-base)
- Open Source Robotics Foundation Docker Images: [GitHub Repository](https://github.com/osrf/docker_images)

これらのリソースはApache License 2.0の下で提供されており、本プロジェクトでもそのライセンス条項に従っています。詳細については、各リソースのライセンスファイルを参照してください。




