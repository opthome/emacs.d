# 简介
## 安装
https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#install
```shell
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-modules
ln -s /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app
```
### 过程错误
#### 启动
首次启动时，报错 *初始化相关错误、doom的错误*
原因：emacs-mac 安装时，会将 doom emacs 安装到本地，将.emacs.d 删除，重新启动即可
#### 运行
通过上面方式安装的 emacs 无法通过命令行运行，通过命令行打开的 emacs 只是一个普通界面
解决：
```shell
	EMACS_HOME=/Applications/Emacs.app/Contents/MacOS 
			#  /opt/homebrew/opt/emacs-mac/Emacs.app/Contents/MacOS
	# 在终端下打开文件,替换命令行默认的emacs 
	alias emacs="${EMACS_HOME}/Emacs -nw"   # 在终端中打开emacs
```
## Emacs介绍
https://zhuanlan.zhihu.com/p/403076883
https://juejin.cn/post/7085254713595133960
https://book.emacs-china.org
Emacs 中有五个功能键： `Control`、 `Meta`、 `Shift`、 `Super`、 `Hyper`
`Hyper` 键更是在现代键盘上消失
`Meta` 对应于普通 PC 键盘上的 `Alt` 键，Mac 电脑上的 `Option`
`Super` 对应 PC 键盘上的 `Win` 键，对应 Mac 电脑上的 `Command`
## Lisp基础
在 Lisp 中，每一对小括号表达了一个列表，列表元素用空格分隔。
在执行 Lisp 时，会把列表的第一个元素作为函数名，后面的元素都是函数的参数
定义函数就用 `defun` 关键字， 设置变量的值用 `setq` 关键字。
`let` 为一组变量圈出一个作用域
`if`/`when`/`unless` 表示条件语句
`t` 表示 true，`nil` 表示空
`'` 表达了后面的元素不进行执行而直接返回它本身
Emacs Lisp 源码文件的后缀名是 `.el`
`;` 以后的内容都是注释
	按照习惯，三个分号开头的注释表示“节”
	两个分号开头的注释表示“段落”
	一个分号开头的是一行代码后面的行内注释

# Configuration
## 我的配置安装
1、下载emacs，将代码克隆到本地 `~/.emacs.d`
2、打开emacs，自动下载相应的包，如果遇到某一行错误，注释掉，或者手动下载（主题）
3、注意：
	安装*all-the-icons*后，重启 Emacs 后安装字体：`M-x` `all-the-icons-install-fonts`

## settings file
当启动 Emacs 时，Emacs 会自动依次寻找以下几个文件之一作为配置文件：
```shell
~/.emacs
~/.emacs.el
~/.emacs.d/init.el
~/.config/emacs/init.el
```
**使用 `~/.emacs.d/init.el` 作为配置文件是最为常见的**。 我们可以将其它各种源文件都放置在 `~/.emacs.d` 目录下，方便管理

### general
`(setq make-backup-files nil)` 关闭备份
`(setq custom-file (expand-file-name "custom.el" user-emacs-directory))`
`(when (files-exists-p custom-file)(load-file custom-file))`   通过图形界面做的一些配置 `~/.emacs.d/custom.el`
### grammar
和 `lua` 的语法类似，有个初始文件 `init.el` 里面包含了其他的配置文件
	在配置文件中一定要加入 `(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))` 引入配置文件
	可以包含多层文件夹，需要在 `init.el` 中添加路径
	配置文件放在 `~/.emacs.d/lisp/`
	使用 `(require '[name])` 进行包含
	在每个配置文件结尾需要提供，使用本配置文件时的名字：`(provide '[name])`
### fonts
下载所需要的字体，在系统中进行安装，然后通过图形化界面进行选择，save options（配置在 `custom.el` ）
## package install
`use-package` 类似 `lua` 中的 `mason` 来进行管理插件
```lisp
;; 安装
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; 国内源
(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(package-initialize)
```
重启 Emacs 输入 
`package-list-packages` 列出来仓库中的所有插件，可以选中相应的插件，会弹出介绍的界面和安装按钮
	`h` 显示帮助
	`U` 检查更新
	`i` 标记安装
	`x` 执行更新
`package-install` 输入插件名安装相应插件
`package-delete` 删除插件
### steps
1、将package代码添加到配置文件中
2、安装 `use-package`，在 `use-package` 中
	`:enture` t 确保一定已安装
	`:defer` 延迟加载，用到时才加载
	`:init` 标签表示加载插件前执行的逻辑（如，启动 `ivy-mode`)
	`:config` 表示加载后执行的逻辑（如，设置一些变量，这显然是加载插件后的逻辑，因此写在 `:config`后面）
	`:bind` 绑定快捷键
	`:hook` hook模式的绑定
3、将要安装的插件加到配置文件中
```lisp
(use-package [name]
  :ensure t
  :init
  :config
  :bind
)
```
4、在 `init.el` 中引用，`(require '[name]` 重启进行安装

## package
### others
*(use-package restart-emacs)*   重启
*(use-package benchmark-init)*  测试启动时间
	使用：`M-x benchmark-init/show-durations-tree` 或者 `M-x benchmark-init/show-durations-tabulated`
### appearance
#### colorscheme
`M-x load-theme` 自带主题
*(use-package gruvbox-theme)*   主题
*(use-package doom-themes)*
`M-x package-install dracula-theme`
*(use-package all-the-icons)*
	重启 Emacs 后安装字体：`M-x` `all-the-icons-install-fonts`
#### mode line
*(use-package smart-mode-line)*   状态栏
### edit
*(use -package vertico)*
*(use -package consult)*
*(use -package orderless)*
*(use -package embark)*
`markdown-mode` 自带，打开markdown文档自动使用
### tools
*(use-package which-key)*   
*(use-package dashboard)*          启动界面
*(use-package highlight-symbol)*   高亮当前符号
*(use-package evil)*               vim插件
	`C-z` 切换vim、emacs
*(use-package treemacs)*           目录树
*(exec-path-from-shell)*           mac下解决环境变量的问题（只在mac下安装）
*(use-package dirvish)*            实时预览文件、目录
	Debian : apt install fd-find poppler-utils ffmpegthumbnailer mediainfo imagemagick tar unzip
	MacOS : brew install coreutils fd poppler ffmpegthumbnailer mediainfo imagemagick
### code
#### auto complete
*(use-package company)*   补全插件
*(use-package company-box)*   显示关键字图标
	`M-p` 和 `M-n` 上下选择， `Meta 键` + 一个数字选择相应标号的备选项
*(use-package yasnippet)*   代码片段
*(use-package yasnippet-snippets)*   模版
*(use-package flycheck)*  静态检查
	python：pylint
	C/C++：clang
#### lsp
*(use-package lsp-mode)*
*(use-package lsp-ui)*
#### debug
*(use-package dap-mode)*    调试，未安装
#### git
*(use-package magit)*    
#### language
	C/C++:
		clang、clangd，通过系统安装
	rust:
		(use-package rust-mode)
		(use-package cargo)
	go:
		(use-package company-go)
		(use-package go-mode)
		(use-package go-fill-struct)
		(use-package go-impl)
		(use-package go-gen-test)
		(use-package go-tag)
	python:
		系统安装pyright，pylint
		(use-package python)
		(use-package lsp-pyright)
		(use-package elpy     尝试代替上面两个插件
		  :ensure t
		  :init
		  (elpy-enable))
# 快捷键
*按生效优先级排序*
```lisp
(define-key key-translation-map (kbd "your-key") (kbd "target-key"))

**你在任何时候按下"your-key"，编辑器将执行"target-key"所绑定的命令。无论当时处于何种编辑状态，是否有minor-mode触发，该映射都不受影响，属于优先级最高的键绑定方式

**特点：由于映射键是完全的跳转到了另一个键上，所以一旦目标键的定义发生了变化，该键也会随之受到影响
```

```lisp
(define-key some-minor-mode-map (kbd "your-key") 'your-command)

**特点：仅在minor-mode激活时有效，定义方便且优先级高，不用担心键冲突
注销方式：绑定为nil
```

```lisp
(local-set-key (kbd "your-key") 'your-command)

**local-set-key主要是在各种major-mode下使用，一般是通过hook设置
	(add-hook 'some-major-mode-hook '(lambda () (local-set-key ...)))

**特点：通过这种方式设置的键绑定仅在该major-mode下生效，不影响其他major-mode，实惠好用
注销方式：绑定为nil，或者
	(local-unset-key (kbd "your-key")
```

```lisp
(global-set-key (kbd "your-key") 'your-command)

**特点：最简单的键绑定方式，一行搞定，无须关心到底是哪个keymap。然而需小心在某些major-mode时会被覆盖。**
注销方式：绑定为nil，或者
	(global-unset-key (kbd "your-key")
```

