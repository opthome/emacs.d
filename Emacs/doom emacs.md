# doom
`doom sync`  类似 :PackerSync 当修改init.el、configuration.el 时，进行同步工作
`doom upgrade`  更新Doom Emacs（如果有）及其所有软件包
`doom env`  （重新）生成一个“envvar文件”，这是Doom在启动时加载的shell环境的快照。如果您的应用程序启动器或操作系统在错误的环境中启动Emacs，您将需要这样做。**这是MacOS上的GUI Emacs用户所必需的。**
`doom doctor` 此命令效果是尝试找到Doom出错的问题

`doom env`  基本不用使用，其作用是让doom 的环境变量和你的shell环境变量同步一下，除非你shell环境变量经常变动，否则是几乎不会用到这个功能的

`doom build`  重新编译所有的包(把el文件编译成elc以提高运行速度)。
`doom info`  输出doom的相关信息，用来给doom提issue用的。如果你需要提issue，那么你需要将这个命令的输出也贴上去，用于判断是否是环境问题。
`doom clean`  这个命令会删除所有的elc文件，执行后你需要使用doom build重新编译它们。
`doom run`  从doom可执行文件的父级目录下启动Emacs。我猜测可能是为了解决一些路径问题。
`doom compile`  将私有配置和已开启的模块编译成字节码。提高运行效率的。
`doom purge`  删除那些已安装，但是没有使用的包，并将其压缩, `-g` 开关压缩现有软件包repos
`doom help`  查看`doom`提供的可用命令的概述
# 配置
## treemacs：
	/Users/wcj/.emacs.d/.local/cache/treemacs-persist
	定义workspace
# 快捷键
## 
`C-o`  回到上一位置
## 
### h
#### 帮助
`SPC h v`    查看变量
`SPC h f`    函数
`SPC h r r`  = doom sync
`SPC h t`    change theme
#### 跳转
`SPC h d c`  跳转至私有配置文件 `configuration.el`
`SPC h d h`  打开doom emacs的文档
### b
`SPC b b`    buffer
### f
`SPC f p`    ~/.doom.d/
`SPC f r`    recent files
### m
`SPC m g g`  可以跳转至指定标题
### o
`SPC o p`    文件树

# language
1、修改 `init.el` 中编程语言对应的选项
2、执行 `doom sync` 自动安装对应的包
	在 `doom sync` 过程中有失败的情况，把 `init.el` 对应的语句注释掉，执行 `doom purge` 清理多余的包
	再重新安装一遍
*注意：
	当打开相应的文件时，可能提示要选择项目目录，此时要正确选择，否则无法实现代码提示*
3、本地不用安装对应的包(pyright)，当打开对应的文件类型时，会提示进行下载
	对应的语言后面要加上 `+lsp` 
```shell
# python : 
	# (python +lsp +pyright)
# js:
	# 安装中错误,解决:
		npm config set registry http://registry.npmjs.org/
		sudo vim /etc/hosts
		104.16.21.35   registry.npmjs.org
		# 再连接代理进行安装，只能安装一个！
# lua:
	# (lua +lsp)
	# 之后打开lua文件，选择服务器进行下载
# java:
	# (java +lsp)
	# 之后打开Java文件，安装jdtls，需要Java 17 环境，参照 [[java/tools]]
	# 打开maven项目，自动加载，估计使用默认仓库位置
```
# 个人模块
*位置:*
	`~/.doom.d/modules/private/[name]/`
*在[name]中存放两个文件：*
	`packages.el` 这个模块要安装的包,用来放安装包的代码，基本上是调用一下package!宏
	`config.el`  针对这个模块的配置,通常是利用 `use-package!` 宏来对每个包进行管理和配置
*注意：*
	[name] 随便取
	我们所有的私有模块都得放在modules/下并且存放在单独的目录下，并且每个模块都必须包含`config.el`和`packages.el`
*例如：*
	`config.el` 
		(use-package! dap-mode
			:custom
			(default-input-method "dap-mode"))
	`packages.el`
		(package! dap-mode)
*编写好私有模块后还需在 init.el 内将其开启，添加如下内容至最后一个括号的前面:*
	:private
	dap-mode
*执行 doom sync*
