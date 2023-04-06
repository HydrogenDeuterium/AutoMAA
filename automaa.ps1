$s = ((adb devices)[1] -split "\t")
if ($s[1] -ne "device"){
    # 已经绑定地址了
    $i=(Read-Host "输入连接ip")
    # 192.168.3.62:40665 or etc
    adb connect $i
}
if ($s[1] -ne "device"){

    Write-Output "连接失败"
    Write-Output $s
    Write-Output "请尝试排查问题后重启程序"
    Read-Host "按任意键退出"
    exit
}

$size=((adb shell wm size) -split ": ")[-1]
$density=((adb shell wm density) -split ": ")[-1]
adb shell wm size 1080x1920
adb shell wm density reset
Write-Output "分辨率调整成功"

# path\to\your\MAA\config
$path = "C:\Program Files\MAA\config\gui.json"
$s = ((adb devices)[1] -split "\t")[0]
Write-Output "adb设备名称："
Write-Output $s

$j = (Get-Content $path | ConvertFrom-Json )
if ($j.'Connect.Address' -eq $s){
    $i=$j.'Connect.Address'
}else {
    Write-Output "正在调整 MAA adb 接入目标"
    $j.'Connect.Address' = $s
    $j | ConvertTo-Json | Out-File $path
}

Write-Output "准备完毕，正在打开 MAA"
Write-Output "正在等待 MAA 关闭"
# path\to\your\MAA
Start-Process "C:\Program Files\MAA\MAA.exe" -NoNewWindow -Wait 
Write-Output "MAA 已关闭，正在回调分辨率"

Write-Output "重启 adb 服务..."
adb start-server

$s = ((adb devices)[1] -split "\t")[1]
if ($s -ne "device"){
    Write-Output 连接已断开 尝试重新连接
    adb connect $i
}
adb shell wm size $size
adb shell wm density $density
