# AutoMAA

实体机 [MAA](https://github.com/MaaAssistantArknights/MaaAssistantArknights/) 自动部署脚本

## 通知

由于 MAA 的[自动化分辨率调整的功能](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev/docs/1.3-%E6%A8%A1%E6%8B%9F%E5%99%A8%E6%94%AF%E6%8C%81.md#%E8%87%AA%E5%8A%A8%E5%8C%96%E6%9B%B4%E6%94%B9%E5%88%86%E8%BE%A8%E7%8E%87)，基本覆盖了本项目的使用场景，因此决定停止维护。

## 介绍

MAA，包括其他一些自动化程序，通常在模拟器上运行。有时候需要在实体机上运行时，对连接到的设备宽高比有要求。

显然，目前大部分实体机设备宽高比通常不满足要求，这个脚本用于连接实体机设备，调整宽高比后启动 MAA。

当 MAA 关闭后，脚本还会复原原始的分辨率与系统缩放。

## 使用方法

> 可以使用 `(wget "https://raw.githubusercontent.com/HydrogenDeuterium/AutoMAA/main/automaa.ps1").content|iex` 来远程启动脚本。
>
> 这需要设定 MAA 的安装目录为 `C:\Program Files\MAA\`。
>
> 也可以在`$PROFILE`中加入以下内容，以获取更好的体验：
```powershell
function automaa  {
  iex ((wget "https://raw.githubusercontent.com/HydrogenDeuterium/AutoMAA/main/automaa.ps1").content)
}
```
> 或者将脚本（本体或者远程启动指令）放到 `PATH` 环境变量目录下


### 1. 启动前的准备操作

  1.1 设置 `adb` 的 `PATH` 环境变量，或手动修改脚本中的 adb 可执行文件路径。
  
  1.2 修改目标 MAA 可执行文件路径，确保在不使用脚本的情况下，MAA 功能正常。
  
### 2. 在要连接到的设备上打开调试。启动脚本。

  2.a 对于有限连接设备的情况，无需任何操作
  
  2.b 对于无线连接的情况，请输入实体设备 IP 地址与连接端口号
  
### 3. 脚本执行

  3.1 脚本调整宽高比，运行 MAA，运行完成后关闭 MAA（也可设置 MAA 完成任务后自动关闭）
  
  3.2 脚本重置宽高比，脚本运行结束

## 故障排查

- 脚本执行成功，但是 MAA 无法连接
  - 请确保脚本和 MAA 使用相同的 adb 可执行文件。
- MAA 可以连接和识别屏幕内容，但是无法进行操作
  - 确保 MAA **设置-连接设置**中**连接配置**为“ADB Input（兼容模式）”。
