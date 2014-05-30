@echo off
echo 请选择你需要配置的项目：
echo 输入（1）配置daoxila_v1_root
echo 输入（2）配置daoxila_v1_cs
echo 输入（3）配置daoxila_v1_sys
echo 输入（4）配置daoxila_v2
echo 输入（5）配置daoxila_v3
echo 输入（6）配置daoxila_v4
echo 输入（7）配置daoxila_wap
set choice=
set /p choice=    请输入选项（1/2/3/4/5/6/7）：
goto %choice%
exit

:1
echo 你选择了配置daoxila_v1_root
copy D:\server\dxlconfig\v1\root\application.ini D:\server\www\daoxila_v1_root\application\configs\application.ini
copy D:\server\dxlconfig\v1\root\Config.php D:\server\www\daoxila_v1_root\library\Ext\Config.php
copy D:\server\dxlconfig\v1\root\Server.php D:\server\www\daoxila_v1_root\library\Ext\Server.php
exit

:2
echo 你选择了配置daoxila_v1_cs
copy D:\server\dxlconfig\v1\cs\application.ini D:\server\www\daoxila_v1_cs\application\configs\application.ini
copy D:\server\dxlconfig\v1\cs\Config.php D:\server\www\daoxila_v1_cs\library\Ext\Config.php
copy D:\server\dxlconfig\v1\cs\Server.php D:\server\www\daoxila_v1_cs\library\Ext\Server.php
exit

:3
echo 你选择了配置daoxila_v1_sys
copy D:\server\dxlconfig\v1\sys\application.ini D:\server\www\daoxila_v1_sys\application\configs\application.ini
copy D:\server\dxlconfig\v1\sys\Config.php D:\server\www\daoxila_v1_sys\library\Ext\Config.php
copy D:\server\dxlconfig\v1\sys\Server.php D:\server\www\daoxila_v1_sys\library\Ext\Server.php
exit

:4
echo 你选择了配置daoxila_v2
copy D:\server\dxlconfig\v2\index.php D:\server\www\daoxila_v2\public
copy D:\server\dxlconfig\v2\config.php D:\server\www\daoxila_v2\config\common
copy D:\server\dxlconfig\v2\application.ini D:\server\www\daoxila_v2\config\zend
exit

:5
echo 你选择了配置daoxila_v3
copy D:\server\dxlconfig\v3\application.ini D:\server\www\daoxila_v3\application\configs\application.ini
copy D:\server\dxlconfig\v3\Config.php D:\server\www\daoxila_v3\library\Ext\Config.php
exit

:6
echo 你选择了配置daoxila_v4
copy D:\server\dxlconfig\v4\system\* D:\server\www\daoxila_v4\configs\system
exit

:7
echo 你选择了配置daoxila_wap
copy D:\server\dxlconfig\wap\system\* D:\server\www\daoxila_wap\configs\system
exit