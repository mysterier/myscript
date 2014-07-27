title: mac下apache虚拟目录配置注意事项
date: 2014-07-27 20:49:02
categories: 问题记录 
tags: 
- mac
- apache
---
##配置虚拟目录
mac买没多久进了水于是烂角落里差不多2年了，现在差不多修好了就重新捣鼓下，搭个开放环境吧。mac也是基于bsd的类unix系统，apache、php都默认装好了。心想只要打开配置文件改改就能跑起来了。这里提下，mac下/etc是作了个软链指向/private/etc。apache的配置文件在/private/etc/apache2/httpd.conf，需要建立个虚拟目录，于是找到Virtual hosts配置项，去除Include虚拟目录配置文件的注释，保存退出。mac下虚拟目录的配置文件在/private/etc/apache2/extra/httpd-vhosts.conf。我需要打开页面以目录形式展示，于是配置后如图
![图片看不到惹](/photo/mac-apache-vhost/p1.png "虚拟目录配置")
保存退出。执行
```bash
$ sudo apachectl start
```
##出现问题
再将tools.lieo指向本地。满心期待的打开页面结果
![图片看不到惹](/photo/mac-apache-vhost/p2.png "结果页")
报404错误，很显然没走我配置的虚拟目录啊。
##查找问题
难不成配置有问题，不科学呀，先查看下目前apache运行下的虚拟目录。执行
```bash
$ sudo apachectl -S
```
来查看,如图
![图片看不到惹](/photo/mac-apache-vhost/p3.png "图3")
##发现问题
结果发现并没有一个虚拟目录。这就奇怪了，明明已经配置了啊，于是再次打开主配置文件，上上下下仔细查看，发现了一个奇怪的地方。
![图片看不到惹](/photo/mac-apache-vhost/p4.png "奇怪的地方")
要开启虚拟目录功能必须WEBSHARING_ON成立啊。顾名思义是要开启web共享。先不管他，直接将虚拟目录的配置文件路径剪切到条件之外，重启apache再看
##解决问题
![图片看不到惹](/photo/mac-apache-vhost/p5.png "重启apache再看")
好啦，读到我配置的虚拟目录了！！
打开页面也成了
![图片看不到惹](/photo/mac-apache-vhost/p6.png "打开页面啦")
##web共享
话说那个web共享就是打开系统偏好设置->共享->web共享，如图
![图片看不到惹](/photo/mac-apache-vhost/p7.png "web共享")
mac的计算机名称也在这里设置！
