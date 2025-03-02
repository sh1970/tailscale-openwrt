# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)
* 本项目最初编写的目的是适配存储不足, 但内存充足的设备, 原理是将下载的tailscale放入/tmp中, 当然你如果追求版本更新, 也可以使用本项目, 如果你存储充足, 请尽量考虑安装到机内存储中，或使用官方命令安装。 (因为国内的CDN有时候是会失效的, 重启路由器下载不下来tailscale就连不上了).
* 注意, 本项目是否可用于您的路由器，请参考以下表格：

|| 硬盘剩余空间 < 80MB | 硬盘剩余空间 > 80MB |
| --- | --- | --- |
| 内存剩余空间 < 80MB | 不可用 | 不可用，但你可以手动将 tailscale 安装到内置存储中, [手动安装方法](https://github.com/CH3NGYZ/tailscale-openwrt/issues/18#issuecomment-2336612695) |
| 内存剩余空间 > 80MB | 可用 | 可用, 但由于Github代理可能会随时失效，请尽量考虑将 tailscale 安装到内置存储中, [手动安装方法](https://github.com/CH3NGYZ/tailscale-openwrt/issues/18#issuecomment-2336612695) |
* zip文件+解压后的可执行文件大约80MB



------------
|  在OpenWRT上部署Tailscale的最简单方法 |
| ------------ |
|  已测试支持的架构：x86_64、aarch64、mipsle、mips、armv7l |
|  未经测试的架构：armv8l、riscv64、mips64、mips64le、mipsle、i386、geode |

- 尽管我的[install.sh](https://github.com/CH3NGYZ/tailscale-openwrt/blob/chinese_mainland/install.sh)脚本中有预设armv8l、armv7l、riscv64、mips、mips64、mips64le、i386、geode这些架构的安装命令，但由于系统以及机器架构的不同，导致运行查看架构的命令 `uname -m` 出来的结果 ***可能*** 不是脚本中预设的内容，所以有可能因为对不上而查找架构失败，因此如果你能测试这个脚本，并在issues中通知运行的结果，我将尽快更新脚本，以及文档中支持的架构部分。
- 如果您想自定义脚本内容，请fork我的仓库，切换到相应的分支，修改/usr/bin/文件，将下载链接更改为您的仓库，Github Actions会自动将修改后的内容打包到tgz中，并将其上传到当前仓库。然后修改install.sh和Readme.MD文件中的用户名以指向您的仓库。
> [此分支的安装脚本及tailscale下载器都添加了多个代理, 如果代理全部失效, 请提issue联系我更换代理](https://github.com/CH3NGYZ/tailscale-openwrt/issues/new)
> 
![image](https://github.com/CH3NGYZ/tailscale-openwrt/assets/56500405/3823d18e-ccfd-459f-a45d-b451b8160ced)

> 注：题外话，在windows平台下clash的TUN模式与Docker Desktop、Tailscale Windows不兼容, 解决办法: 暂时关闭TUN, 登录完毕后再打开.
>  [原因](https://chengyunzhe.notion.site/chengyunzhe/clash-for-windows-docker-tailscale-fccff782bd2c482cb9b7d3dd08c58b18)
------------

## 0x00 安装
全新安装
```
wget -O /tmp/install.sh https://ghfast.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh && rm -f /tmp/install.sh
```
> 请注意, 由于tailscale 1.48.0版本后支持了nftables，本项目于2024.8.20、tailscale:1.72.0时更新支持，将环境变量`TS_DEBUG_FIREWALL_MODE=auto`传递给tailscale进程，如果你发现系统日志中tailscale无法正常启动，请考虑设置具体的防火墙模式（修改/etc/init.d/tailscale），详见[设置](https://tailscale.com/kb/1294/firewall-mode#how-to-set-the-firewall-mode)


------------

## 0x01 卸载
- ***请注意不要在ssh连接期间卸载，因为ssh连接将丢失！使用风险自负。***

```
wget -O /tmp/uninstall.sh https://ghfast.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/uninstall.sh && chmod +x /tmp/uninstall.sh && /tmp/uninstall.sh && rm -f /tmp/uninstall.sh
```
------------
## 0x02 升级
- 升级tailscale
- ***每次启动openwrt时tailscale_downloader都会通过网络下载最新版本的TailScale的可执行文件。***
```shell
reboot
```

- 保留配置升级
- ***如果下载器脚本(tailscale_downloader)存在版本更新(更新代理地址等), 运行以下命令更新最新下载器脚本***:
```
rm -rf /tmp/tailscale* && wget -O /tmp/install.sh https://ghfast.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh && rm -f /tmp/install.sh && reboot
```
------------

#### 如果好用，麻烦动动小手点个Star，谢谢啦！
## 如果有新版本可用, 但是还没到actions运行时间, 你可以手动点击start触发actions运行, 更新最新版本.
------------
### 特别感谢:
[adyanth [openwrt-tailscale-enabler]](https://github.com/adyanth/openwrt-tailscale-enabler) 
