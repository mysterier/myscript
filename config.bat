@echo off
echo ��ѡ������Ҫ���õ���Ŀ��
echo ���루1������daoxila_v1_root
echo ���루2������daoxila_v1_cs
echo ���루3������daoxila_v1_sys
echo ���루4������daoxila_v2
echo ���루5������daoxila_v3
echo ���루6������daoxila_v4
echo ���루7������daoxila_wap
set choice=
set /p choice=    ������ѡ�1/2/3/4/5/6/7����
goto %choice%
exit

:1
echo ��ѡ��������daoxila_v1_root
copy D:\server\dxlconfig\v1\root\application.ini D:\server\www\daoxila_v1_root\application\configs\application.ini
copy D:\server\dxlconfig\v1\root\Config.php D:\server\www\daoxila_v1_root\library\Ext\Config.php
copy D:\server\dxlconfig\v1\root\Server.php D:\server\www\daoxila_v1_root\library\Ext\Server.php
exit

:2
echo ��ѡ��������daoxila_v1_cs
copy D:\server\dxlconfig\v1\cs\application.ini D:\server\www\daoxila_v1_cs\application\configs\application.ini
copy D:\server\dxlconfig\v1\cs\Config.php D:\server\www\daoxila_v1_cs\library\Ext\Config.php
copy D:\server\dxlconfig\v1\cs\Server.php D:\server\www\daoxila_v1_cs\library\Ext\Server.php
exit

:3
echo ��ѡ��������daoxila_v1_sys
copy D:\server\dxlconfig\v1\sys\application.ini D:\server\www\daoxila_v1_sys\application\configs\application.ini
copy D:\server\dxlconfig\v1\sys\Config.php D:\server\www\daoxila_v1_sys\library\Ext\Config.php
copy D:\server\dxlconfig\v1\sys\Server.php D:\server\www\daoxila_v1_sys\library\Ext\Server.php
exit

:4
echo ��ѡ��������daoxila_v2
copy D:\server\dxlconfig\v2\index.php D:\server\www\daoxila_v2\public
copy D:\server\dxlconfig\v2\config.php D:\server\www\daoxila_v2\config\common
copy D:\server\dxlconfig\v2\application.ini D:\server\www\daoxila_v2\config\zend
exit

:5
echo ��ѡ��������daoxila_v3
copy D:\server\dxlconfig\v3\application.ini D:\server\www\daoxila_v3\application\configs\application.ini
copy D:\server\dxlconfig\v3\Config.php D:\server\www\daoxila_v3\library\Ext\Config.php
exit

:6
echo ��ѡ��������daoxila_v4
copy D:\server\dxlconfig\v4\system\* D:\server\www\daoxila_v4\configs\system
exit

:7
echo ��ѡ��������daoxila_wap
copy D:\server\dxlconfig\wap\system\* D:\server\www\daoxila_wap\configs\system
exit