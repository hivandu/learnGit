> 此Note是在《Pro Git》基础上的学习笔记
> 
> 原文作者: Scott Chacon
> 
> 翻译制作: Andor Chen　　
> 
> 地址链接: http://leanpub.com/progit-cn
> 
> This version was published on 2014-05-14
> 
> This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License][1]　

# Git 基础
## 初次运行Git前的配置
`git config`
有三个地方存放这些变量
- `/ect/gitconfig` 对所有用户普遍适用 ，`git config --system`读写的就是这个文件
- `~/.gitconfig`用户目录，只适用于当前用户。`git config --global`读写的是这个
- `wordspace/.git/config`当前项目有效，编辑`workspace/.git/config`会覆盖`/etc/gitconfig`中的同名变量
### 用户信息
	git config --global user.name "Hivan Du"
	git config --global user.email "doo@hivan.me"

### 文本编辑器
`git config —global core.editor sm`

### 差异分析工具
`git config —global merge.tool vimdiff`
“Git 可以理解 kdiff3，tkdiff，meld，xxdiff，emerge，vimdiff，gvimdiff，ecmerge，和 opendiff 等合并工具的输出信息。”

### 查看配置信息
`git config —list`

ex: `git config user.name`

# Git 基础
## 取得项目的Git仓库
### 初始化新仓库
	git init
	git add *.c
	git add README
	git commit -m 'initial project version'

### 克隆现有仓库
	git clone git://github.com/xxxxx/xxx.git
	git clone git://github.com/xxxxx/xxx.git xxxx.git

## 记录每次更新到仓库
- untracked
- unmodified
- modified
- staged
### 检查当前文件状态
	git status

### 跟踪新文件
	git add README

### 暂存已修改文件
	git add xxxxxx.md
> “译注：其实 git add 的潜台词就是把目标文件快照放入暂存区域，也就是 add file into staged area，同时未曾跟踪过的文件标记为需要跟踪。这样就好理解后续 add 操作的实际意义了。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 

### 忽略某些文件
	cat .gitignore
需要修改`.gitignore`，
规范格式如下:
- 所有空行或者以注释符号 ＃ 开头的行都会被 Git 忽略。
- 可以使用标准的 glob 模式匹配。
- 匹配模式最后跟反斜杠（/）说明要忽略的是目录。
- 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。
\- 
> “所谓的 glob 模式是指 shell 所使用的简化了的正则表达式。星号（\*）匹配零个或多个任意字符；[abc]() 匹配任何一个列在方括号中的字符（这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）；问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配（比如 [0-9]() 表示匹配所有 0 到 9 的数字）。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 

ex:

	# 此为注释 – 将被 Git 忽略
	# 忽略所有 .a 结尾的文件
	*.a
	# 但 lib.a 除外
	!lib.a
	# 仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
	/TODO
	# 忽略 build/ 目录下的所有文件
	build/
	# 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt
	doc/*.txt
	# ignore all .txt files in the doc/ directory
	doc/**/*.txt

>  摘录来自: Andor Chen. “精通 Git”。 iBooks. 

### 查看已经暂存和未暂存的更新
	git status

查看尚未暂存的文件更新哪些部分，不加参数直接输入`git diff`
**“此命令比较的是工作目录中当前文件和暂存区域快照之间的差异，也就是修改之后还没有暂存起来的变化内容。”**

查看已经暂存的文件和上次提交的快照之间的差异:
	git diff --cached(--staged)

### 提交更新
	git commit
一半都是`VIM`，可以更改默认editor
或者直接参加参数`git commit -m "want change editor"`
or `git commit -a -m "want change editor"`来跳过git add 步骤

### 跳过适用暂存区域
	git commit -a -m 'added new benchmarks'

### 移除文件
- 从文件目录中删除
	`git rm delfile.md`
- 从仓库删除（亦从暂存区域删除）
	`git rm --cached delfile.md`
- 也可以使用`glob`模式
	`git rm log/\*.log`

### 移动文件
	git mv file_from file_to

ex: `git mv README.txt README`　

## 查看提交历史
	git log
- 用`-p`来显示每次提交的内容差异，用`-2`则显示最近两次更新
		git log -p -2
- 单词层面对比更容易观察，Git提供了`--word-diff`选项
		git log -U1 --word-diff
	进行单词比对的时候，可能希望context从默认3行，减为1行，那么可以使用`-U1`选项
- 仅显示简要的增改行数统计
		git log --stat
- 指定使用完全不同默认格式的方式展示提交历史,用`--pretty`,比如用`oneline`将每个提交放在一行显示。
		git log --pretty=oneline
	另外还有`short`,`full`,`fuller`可以使用
- `format`可以定制要显示的记录格式
		git log --pretty=format:"%h-%an, %ar:%s"

选项   说明
%H  提交对象（commit）的完整哈希字串
%h  提交对象的简短哈希字串”
%T  树对象（tree）的完整哈希字串
%t  树对象的简短哈希字串
%P  父对象（parent）的完整哈希字串
%p  父对象的简短哈希字串
%an 作者（author）的名字
%ae 作者的电子邮件地址
%ad 作者修订日期（可以用 -date= 选项定制格式）
%ar 作者修订日期，按多久以前的方式显示
%cn 提交者(committer)的名字
%ce 提交者的电子邮件地址
%cd 提交日期
%cr 提交日期，按多久以前的方式显示
%s  提交说明”

- 结合`--graph`选项，可以看到开头多出一些ASCII字符串表示的简单图形。展示每个提交所在的分支及其分化衍合情况。
		git log --pretty=format:"%h %s" --graph

选项  说明
-p  按补丁格式显示每个更新之间的差异。
--word-diff 按 word diff 格式显示差异。
--stat  显示每次更新的文件修改统计信息。
--shortstat 只显示 --stat 中最后的行数修改添加移除统计。
--name-only 仅在提交信息后显示已修改的文件清单。
--name-status   显示新增、修改、删除的文件清单。
--abbrev-commit 仅显示 SHA-1 的前几个字符，而非所有的 40 个字符。
--relative-date 使用较短的相对时间显示（比如，“2 weeks ago”）。
--graph 显示 ASCII 图形表示的分支合并历史。
--pretty    使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（后跟指定格式）。
--oneline   `--pretty=oneline --abbrev-commit` 的简化用法。

### 限制输出长度
按时间限制,`--since`和`--until`选项
	git log --since=2.weeks
`--author`显示指定作者的提交，`--grep`选项搜索提交说明中的关键字。如果同事满足这两个条件搜索，必须用`--all-match`选项。

另外一个适用的是路径(path)
“选项   说明
-(n)    仅显示最近的 n 条提交”
--since, --after    仅显示指定时间之后的提交。
--until, --before   仅显示指定时间之前的提交。
--author    仅显示指定作者相关的提交。
--committer 仅显示指定提交者相关的提交。

ex:

	git log --pretty="%h-%s" --author="Hivan Du" --since="2015-1-10" --before="2015-1-11" --no-merges -- add/

### 图形化工具
	gitk

## 撤销操作
### 修改最后一次提交
	git commit --amend

### 取消已经暂存的文件
	git reset HEAD README.md

### 取消对文件的修改
	git checkout -- README.md

> “记住，任何已经提交到 Git 的都可以被恢复。即便在已经删除的分支中的提交，或者用 --amend 重新改写的提交，都可以被恢复（关于数据恢复的内容见第九章）。所以，你可能失去的数据，仅限于没有提交过的，对 Git 来说它们就像从未存在过一样。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 

## 远程仓库的使用
### 查看当前的远程库
	git remote
也可以加上`-v`(—verbose)，显示对应的克隆地址
	git remote -v

### 添加远程仓库
	git remote add [shortname] [url]

ex: `git remote add test git@gitcafe.com:hivandu/LearnGit.git`

现在可以用字符串`test`纸袋对应的仓库地址了，比如说，要抓取所有的gitcafe有的，但是本地仓库没有的信息，可以运行`git fetch test`
gitcafe上的主分支master已经完全可以在本地访问了，对应的名字是`test/master`，可以合并到自己的某个分支，或者切换到这个分支。

### 从远程仓库抓取数据
	git fetch [remote-name]

如果clone了一个仓库，此命令会自动将远程仓库归于`origin`名下，所以，`git fetch origin`会抓取从你上次克隆以来别人上传到此仓库中的所有更新。**`fetch`命令只是将远端的数据拉到本地仓库，并不自动合并到当前工作分支，只有当确实准备好了，才能手工合并。**

如果设置了某个分支用于跟踪某个远端仓库的分支，可以使用`git pull`自动抓取数据下来，然后将远端分支自动合并到本地仓库中的当前分支。

一般我们运行`git pull`,目的都是要从原始克隆的远端仓库中抓取数据后，合并到工作目录中的当前分支。

### 推送到远程仓库
	git push [remote-name] [branch-name]

ex : `git push origin master`

### 查看远程仓库信息
	git remote show [remote-name]

ex: `git remote show origin`

### 远程仓库的删除和重命名
	git remote rename test paul
	git remote rm paul
 

## 打标签
### 列显示已有的标签
	git tag
	git tag -l 'v1.4.2'

### 新建标签
Git有两种标签类型: 轻量级的`lightweight` 和 附注的`annotated`。
### 含附注的标签
	git tag -a v1.1 -m 'my version 1.1'

可以使用`git show`来查看相应标签的版本信息。
	git show v1.1
### 签署标签
如果有自己的私钥，还可以用GPG来签署标签，只需要把之前的`-a`改为`-s`(signed)即可:
	git tag -s v1.2 -m 'my signed 1.2 tag'
**在Mac内必须想要安装gpgtool**: `brew install gpg`

### 轻量级标签
就是一个保存着对应提交对象的校检和信息的文件。一个`-a`,`-s`,`-m`都不要用。直接给出标签名字
	git tag v1.3-lw

### 验证标签
	git tag -v [tag-name]

### 后期加注标签
打标签的时候跟上对应提交对象的校验
	git tag -a v1.0 8f3e6e

### 分享标签
	git push origin [tagname]

ex: `git push origin v1.0`
或一次推送所有标签

	git push origin --tags

## 技巧和窍门
### 自动补全
如果你用的是 Bash shell，可以试试看 Git 提供的自动补全脚本。下载 Git 的源代码，进入 contrib/completion 目录，会看到一个 git-completion.bash 文件。将此文件复制到你自己的用户主目录中（译注：按照下面的示例，还应改名加上点：`cp git-completion.bash ~/.git-completion.bash）`，并把下面一行内容添加到你的 .bashrc 文件中：
	source ~/.git-completion.bash

也可以为系统上所有用户都设置默认使用此脚本。Mac 上将此脚本复制到 `/opt/local/etc/bash_completion.d` 目录中，Linux 上则复制到 `/etc/bash_completion.d/` 目录中。这两处目录中的脚本，都会在 Bash 启动时自动加载。

在输入 Git 命令的时候可以敲两次跳格键（Tab），就会看到列出所有匹配的可用命令建议：

	git co<tab><tab>
	commit config

## Git 命令别名
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status

比如取消暂存文件的输入:

	git config --global alias.unstage 'reset HEAD --'

last命令:

	git config --global alias.last 'log -1 HEAD'

查看最后一次提交，就变得简单多了:

	git last

如果是外部命令，而非Git子命令，可以在命令前加上`!`就行

	git config --global alias.visual '!gitk'

# Git分支
## 何谓分支
Git暂存参佐会对每一个文件计算校验和（SHA-1哈希字串），然后把当前版本的文件快照保存到Git仓库中（Git使用blob类型的对象存储这些快照），并将校验和加入暂存区域。
`git commit` 新建一个提交对象前，Git会先计算每一个子目录的校验和，然后在Git仓库中将这些目录保存为树对象。之后Git创建的提交对象，除了保存相关信息以外，还包含着指向这个树对象的指针，如此它就可以在将来需要的时候，重现此次快照的内容了。
Git中的分支，其实本质上仅仅是指向commit对象的可变指针。
**创建一个新的分支**
	git breanch testing

git 保存着一个名问HEAD的特别指针，它指向你正在工作中的本地分支的指针(将HEAD想象为当前分支的别名)。
**切换分支**
	git checkout testing
这样HEAD指针就指向了`testing`
## 分支的新建与合并
### 分支的新建与切换
	git checkout -b iss53

相当于:

	git branch iss53
	git checkout iss53

提示`Fast-forward` ，由于当前mster所在提交是要并入hotfix分支的直接上游，Git只需要把master分支指针直接右移。如果顺着一个分支走下去可以到达另一个分支的话，那么Git合并两者，值会简单的右移指针。

**删除分支:**
	git branch -d hotfix

![git\_tree][image-1]

### 分支的合并
	git merge

这次Git是将两个分支的末端以及他们的共同祖先进行一次简单的三方合并计算，这次没有简单的指针右移，而是对三方合并后的结果重新做一个新的快照。
新快照比较特殊，有两个祖先

### 遇到冲突时的分支合并
	git mergetool

文件比对工具: Kaleidoscopeapp
Git 比对插件: [KSDIFF][4]

post: [https://tommcfarlin.com/kaleidoscope-git-diff-tool/][5]


## 分支的管理
查看分支清单: `git branch`
查看各个分支最后一个提交对象的信息: `git branch -v`
筛选已经（尚未）与当前分支合并的分支`--merged`和`--no-merged`

	git branch -d testing 

如果testing还没有合并，会提示错误，但是如果想强制执行，使用`-D`

## 利用分支进行开发的工作流程
### 长期分支
比如,`master`储存稳定代码，还有一个名为`develop`或`next`的平行分支，专门用于后续开发，或仅用于稳定性测试。一旦稳定了，便可以把它合并到`master`里。

某些大型项目含有`proposed`(建议)， `pu`(proposed updates, 建议更新)分支。

### 特性分支
`Topic`分支。一个特性分支是指一个短期的，用来实现单一特性或与其相关工作的分支。

## 远程分支
我们用(远程仓库名)/(分支名)这样的形式来表示远程分支。
可以运行`git fetch origin`来同步远程服务器上的数据到本地

	git remote add teamone git://git.team1.ourcompany.com/

### 推送本地分支
如果有一个叫`serverfix`的分支需要和他人一起开发，可以运行`git push (远程仓库名)(分支名)`

	git push origin serverfix
	
	git push origin serverfix:awesomebranch

通过这个语法，可以把本地分支推送到某个命名不同的远程分支，如远程分支叫`awesomebranch`

`fetch`下载好新的远程分支，仍然无法编辑该远程仓库中的分支。

合并到当前分支

	git merge origin/serverfix

分化一个新的分支:

	git checkout -b serverfix origin/serverfix

### 跟踪远程分支
远程分支checkout出来的本地分支，称为`tracking branch`（跟踪分支）。

`git push`会自省推断向那个服务器的哪个分支推送数据
`git pull`会获取所有远程索引，并合并到本地

	git checkout -b [分支名][远程名]/[分支名]

git 1.6.2以上版本，可以用`--track`简化

	git checkout --track origin/serverfix

### 删除远程分支
	git push origin :serverfix


## 分支的衍合
分支整合有两个办法:`merge` and `rebase`(衍合)。

### 基本的衍合操作
`rebase`命令，是把一个分支里的提交改变移动到另一个分支里重放一遍。

### 有趣的衍合
	git rebase --onto master server client

这好比在说：“取出 client 分支，找出 client 分支和 server 分支的共同祖先之后的变化，然后把它们在 master 上重演一遍”.

### 衍合的风险
一旦分支中的提交对象发布到公共仓库，就千万不要对该分支进行衍合操作”

如果把衍合当成一种在推送之前清理提交历史的手段，而且仅仅衍合那些尚未公开的提交对象，就没问题。如果衍合那些已经公开的提交对象，并且已经有人基于这些提交对象开展了后续开发工作的话，就会出现叫人沮丧的麻烦。

# 服务器上的Git
## 协议
四种: 本地传输， SSH协议， Git协议和HTTP协议
除了HTTP协议，其他协议都要求服务器端安装并运行Git。

### 本地协议
**Local Protocol**

	git clone /opt/git/project.git

or

	git clone file:///opt/git/project.git

`file://`路径，Git会调用它平时通过网络来传输数据的供需，效率较低。原因是当你需要一个不包含无关引用或对象的干净仓库副本的时候。
要添加一个本地仓库作为现有Git项目的远程仓库，可以这样

	git remote add local_proj /opt/git/project.git

### SSH 协议
SSH是唯一一个同时支持读写操作的网络协议，同时也是一个验证授权的网络协议;

	git clone ssh://user@server/project.git

or

	git clone user@server:project.git

### Git协议
打算支持Git协议的仓库，需要先创建`git-daemon-export-ok`文件

### HTTP/S 协议
下面操作允许通过HTTP对仓库进行读取:

	$ cd /var/www/htdocs
	$ git clone --bare /path/to/git_project
	git project.git
	$ cd gitproject.git
	$ mv hooks/post-update.sample hooks/post-update
	$ chmod a+x hooks/post-update

之后:

	git clone http://example.com/gitproject.git

## 服务器上部署Git
架设Git服务器前，先要把现有仓库导出为裸仓库
克隆时使用`--bare`选项

	git clone --bare my_project my_project.gits
`git clone`相当于 `git init`+`git fetch`

整体效果大致相当于:

	cp -Rf my_project/.git my_project.git

### 把裸仓库移动到服务器上
有了裸仓库的副本后，剩下的就是把它放到服务器上并设定相关协议。

	scp -r my_project.git user@git.example.com:/opt/git

现在，所有对该服务器有SSH访问权限，并可读取`/opt/git`目录的用户都可以用下面的命令克隆该项目:

	git clone user@git.example.com:/opt/git/my_project.git

设置组权限可写:

	ssh user@git.example.com
	cd /opt/git/my_project.git
	git init --bare --shared

### 小型安装
**部署Git的其他内容，容后在学** — page:149

## 生成SSH公钥
	ssh-keygen

Github上有关SSH公钥的向导: [http://github.com/guides/providing-your-ssh-key][6]

	cat id_rsa.pub
## 架设服务器
…
## 公共访问

## GitWeb

## Gitosis

## Gitolite
### 安装
### 定制安装
### 配置文件和访问规则
### 带‘拒绝’的高级访问控制
### 通过改变文件限制push
### 个人分支
### “通配符”仓库
### 其他功能

## Git守护进程
## Git 托管服务
Git最新的托管服务列表: [https://git.wiki.kernel.org/index.php/GitHosting][7]
### Github
### 从Subversion导入项目
### 添加协作开发者
### 派生项目

# 分布式Git
## 分布式工作流程
### 集中式工作流
第一个开发者可以顺利的把数据推送到服务器，而第二个开发者在提交修订之前，必须先下载合并服务器上的数据，解决冲突之后才能推送数据到共享服务器上。这就好比是在用Subversion（或其他CVCS）一样。
在有冲突时，Git根本不会让用户覆盖他人代码，它直接驳回第二个人的提交操作。

### 集成管理员工作流
1. 项目未护着可以推送数据到公共仓库blessed repository
2. 贡献者克隆此仓库，修订或编写新代码
3. 贡献者推送数据到自己的公共仓库developer public
4. 贡献者给维护者发送邮件，请求拉去自己的最新修订。
5. 未护着在自己的本地的integration manger仓库中，将贡献者的仓库加为远程仓库，合并更新并做测试。
6. 未护着将合并后的更新推送到主仓库blessed repository

### 司令官和副官工作流
1. 一般的开发者在自己的特性分支上工作，并不定期地根据主干分支（dictator 上的 master）衍合。
2. 副官（lieutenant）将普通开发者的特性分支合并到自己的 master 分支中。
3. 司令官（dictator）将所有副官的 master 分支并入自己的 master 分支。
4. 司令官（dictator）将集成后的 master 分支推送到共享仓库 blessed repository 中，以便所有其他开发者以此为基础进行衍合。

## 为项目做贡献
### 提交指南
Git项目本身提供了一份文档(Git项目源代码目录中Documentation/SubmittingPatches)。

- “首先，请不要在更新中提交多余的白字符（whitespace）。Git 有种检查此类问题的方法，在提交之前，先运行 git diff --check，会把可能的多余白字符修正列出来。下面的示例，我已经把终端中显示为红色的白字符用 X 替换掉：”
- “接下来，请将每次提交限定于完成一次逻辑功能。并且可能的话，适当地分解为多次小更新，以便每次小型提交都更易于理解。如果针对两个问题改动的是同一个文件，可以试试看`git add --patch`的方式将部分内容置入暂存区域。
- “最后需要谨记的是提交说明的撰写。写得好可以让大家协作起来更轻松。一般来说，提交说明最好限制在一行以内，50 个字符以下，简明扼要地描述更新内容，空开一行后，再展开详细注解。”

来自tpope.net的Time Pope的提交说明格式模板:

> 本次更新的简要描述（50 个字符以内）
> 
> 如果必要，此处展开详尽阐述。段落宽度限定在 72 个字符以内。
> 某些情况下，第一行的简要描述将用作邮件标题，其余部分作为邮件正文。
> 其间的空行是必要的，以区分两者（当然没有正文另当别论）。
> 如果并在一起，rebase 这样的工具就可能会迷惑。
> 
> 另起空行后，再进一步补充其他说明。
> 
> - 可以使用这样的条目列举式。
> 
> - 一般以单个空格紧跟短划线或者星号作为每项条目的起始符。每个条目间用一空行隔开。
>   不过这里按自己项目的约定，可以略作变化。”
> **摘录来自: Andor Chen. “精通 Git”。 iBooks. **

强烈建议去git项目仓库下运行`git log --no-merges`看看。

### 私有小型团队
### 私有团队间协作
### 公开的小型项目
	git clone [url]
	cd project
	git checkout -b featureA

### 公开的大型项目
可以用`git farmat-patch`来生成`mbox`格式的文件然后作为附件发送。
每个提交都会封装为一个`.patch`后缀的`mbox`文件，其中只包含一封邮件，邮件标题就是提交消息，邮件内偶然那个包含补丁正文和Git版本号。

	git format-patch -M origin/master

Git提供了一个IMAP发送补丁文件的工具。另外，Git源代码中有一个Documentation/SubmittingPatches文件，可以仔细读读，看看其他邮件程序的相关引导。

首先在`~/.gitconfig`文件中配置imap项，每个选项都可用`git cofing`命令分别设置，当然直接编辑文件添加以下内容更便捷：

	[imap]
	  folder = "[Gmail]/Drafts"
	  host = imaps://imap.gmail.com
	  user = user@gmail.com
	  pass = p4ssw0rd
	  port = 993
	  sslverify = false”

## 项目的管理
### 使用特性分支进行工作
如果要继承新的代码进来，最好局限在特性分支上做。
现在先新建临时分支:

	git checkout -b sc/ruby_client master

### 采纳来自邮件的补丁
`git apply`或者`git am`

#### apply命令
补丁是`git diff`，或者其他`diff`命令生成的，就该用`git apply`

	git apply /tem/patch-ruby-client.patch

用`--check`检查

	git apply --check 0001-seeing-if-this-helps-the-gem.patch

#### 使用am命令应用补丁
对于`format-patch`制作的新补丁，应该用`git am`。

	git am 0001-limit-log-function.patch

有时候Git会在有冲突的文件里加入冲突解决标记，这与合并或衍合操作一样。解决办法也一样，先编辑文件消除冲突，然后暂存，最后运行`git aam --resolved`提交修正结果:

	[fix the file]
	git add ticgit.gemspec
	git am --resolved
	Applying: seeing if this helps the gem

如果想让Git更只能的处理冲突，可以用`-3`选项进行三方合并。

对于一次应用多个补丁所用的mbox格式文件，可以用`am -i`，这样打每个补丁前会停住，询问该如何操作

### 检出远程分支
	git remote add jessica git://github.com/jessica/myproject.git
	git fetch jessica
	git checkout -b rubyclient jessica/ruby-client

临时合作，只需要`git pull`抓取远程仓库上的数据，合并到本地临时分支就可以了。

	git pull git://githun.com/xxx/project.git

### 决断代码取舍
先看特性分支上都有那些新增的提交，比如在`contrib`特性分支上打了两个补丁，仅查看这两个补丁的提交信息，可以用`--not`选项指定要屏蔽的分支`master`，这样会剔除重复的提交历史:

	git log contrib --not master

如果想缠看当前分支同其他分支合并时的完整内容差异，有一个小窍门:

	git diff master

准确的说，是比较特性分支和它同master分支的共同祖先之间的差异。

可以手动定位它们的共同祖先进行比较:

	$ git merge-base contrib master
	36c7db1hsosd6sda91jdsapl19hecheoal39sjds01
	$ git diff 36c7db

但这么做很麻烦，所以Git提供了便捷的`...`语法。对于`diff`命令，可以把`...`加在原始分支(拥有共同祖先)和当前分支之间:

	git diff master...contrib

### 代码集成
#### 合并流程
小型项目可以新建特性分支Ex: `iss234`,完成开发后并入`master`
大型项目可以维护两个长期分支`master`和`develop`，在`develop`中衍分特性分支进行开发和合并，确认`develop`中的代码稳定可发行，再将master分支快进到稳定点。平时这两个分支都会推送到公开的代码库。

这样，即可检出最近稳定版本，确保正常使用；也能检出开发版本，使用最前沿的新特性。

#### 大项目的合并流程
Git项目本身有四个长期分支: 发布的`master`分支，用于合并基本稳定特性的`next`分支，用于合并仍需改进特性的`pu`（proposed updates）分支，以及用于除错维护的`maint`(maintenance)分支。

`master`一直快进，`next`偶尔衍合，`pu`频繁衍合
`maint`分支是以最近一次发行版为基础分化而来，用于维护除错补丁。

#### 衍合与挑拣(cherry-pick）的流程
挑拣可以只引入其中一个`commits`
加入值希望提取`e43a6`到主干分支，可以:

	git cherry-pick e43a6dhe3034ksndhgdgadsakxgc783h31ddlf

这会引入`e43a6`的代码，但是会得到不同的SHA-1值

### 给发行版签名
	git tag -s v1.5 -m 'my signed 1.5 tag'

完成签名后，如何分发PGP公钥(public key)是个问题。（分发公钥是为了验证标签）。Git可以把key作为blob变量写入Git库，然后把它的内容直接写在标签里。`gpg --list-keys`命令可以显示出你所拥有的可以：

	gpg --list-keys
	/Users/du/.gnupg/pubring.gpg
	----------------------------
	pub   2048R/2944EE1F 2015-01-14 [有效至：2016-01-14]
	uid                  Hivan Du (http://hivan.me/) <doo@hivan.me>
	sub   2048R/3A65452E 2015-01-14 [有效至：2016-01-14]

然后，导出key的内容并精油管道符传递给`git hash-object`,之后key会以 blob类型写入Git中，最后返回这个blob量的SHA-1值

	gpg -a --exprot 2944EE1F | git hash-object -w --stdin
	b7db1fde0db0218f003920aa0ae14a7697dsad37

现在Git已经包含了这个Key的内容，可以通过不同的SHA-1值指定不同的Key来创建标签

	git tag -a maintainer-pgp-pub

之后，可以将maintainer-pgp-pub 标签公布给所有人

	git push --tags

如果有人要校检标签，可以使用如下命令导入你的Key:

	git show maintainer-pgp-pub | gpg --import

### 生成内部版本号
`git describe`来得到一个便于理解的提交号

### 准备发布
发布一个新版本，首先要将代码压缩归档，方便那些没有Git的人们。

	git archive master --prefix='project/' | gzip > `git describe master`.tar.gz

如果要发布zip压缩包

	git archive master --prefix='project/' --format=zip > `git describe master`.zip

### 制作简报
使用`git shortlog`可以方便快捷的制作一份修改日志.
加入你上次发布的版本是v1.0.1，下面的命令将给出自从上次发布之后的所有提交的简介

	git shortlog --no-merges master --not v1.0.1


# Git 工具

## 修订版本(Revision)选择
### 单个修订版本
### 简短的SHA
	git show 1c002dd4b536e7479fe34593e72e6c6c1819e53b
	git show 1c002dd4b536e7479f
	git show 1c002dd

Git 可以为你的SHA-1值生成出简短且唯一的缩写。如果你传递`--abbrev-commit`给`git log`，输出结果里就会使用简短且唯一的值

	git log --abbrev-commit --pretty=oneline

### 关于SHA-1的简短说明

### 分支引用
如果topic1分支指向ca82a6d,下面等价:

	git show ca82a6d
	git show topic1

`rev-parse`，探测工具，可以查看一个例子中被间歇的SHA-1,或者某个分支指向哪个特定的SHA.

	git rev-parse topic1

### 引用日志里的简称
	git reflog

如果想查看HEAD在五次前的值，可以引用日志的输出中的`@{n}`引用

	git show HEAD@{5}

也可以查看某个分支在一定时间前的位置

	git show master@{yesterday}

想查看`git log`输出格式的引用日志信息:

	git log -g master

引用日志信息值存于本地

### 祖先引用
可以使用`^`

	git show HEAD^
	git show d921970^2

另外一个指明祖先提交的方法是`~`
`git show HEAD~3`也可以写成`git show HEAD^^^`

### 提交范围
#### 双点
要看看实验分支那些没有被提交到主分支，可以使用`master..experiment`

	git log master..experiment

相反的，可以交换提交名字。
这个语法的另一种常见也哦哦那个吐是查看你将把什么推送到远程:

	git log origin/master..HEAD

这条命令显示任何在你当前分支上而不在远程origin上的提交。
也可以留空一边，让Git来假定它是HEAD

	git log origin/master..

#### 多点
以下等同

	git log refA..refB
	git log ^refA refB
	git log refB --not refA

加入想查找从`refA`或`refB`包含的但是不被`refC`包含的提交，可以输入下面中的一个:

	git log refA refB ^refC
	git log refA refB --not refC

#### 三点
	git log master...experiment

log命令的一个常用参数是`--left-right`，会显示每个提交到底处于那一侧的分支。这使得数据更加有用

	git log --left-right master...experiment

### 交互式暂存
运行`git add`时加上`-i`或者`--interactive`，Git就会进入了一个交互式的`shell`模式:

	git add -i

### 暂存和撤回文件
如果在`what now>`的提示后输入2或者u,这个脚本会提示你那些文件你想要储存:

### 暂存补丁
在`what now>`下输入5或者p,Git会询问那些文件你希望部分暂存，然后对于被选中文件的每一节，他会逐个显示文件的差异区块并询问你是否希望暂存他们:

此处你可以输入`?`显示列表.

## 储藏(Stashing)
正处理项目某一部分的工作，而这个时候需要转到其他分支，但是又不想提交进行了一半的工作，否则以后无法回到这个工作点，解决办法就是`git stash`

### 储藏你的工作
	git stash

如果要查看储存列表

	git stash list

如果想要应用储藏

	git stash apply stash@{0}

如果不指明，Git会使用最近的储藏并尝试使用它:

	git stash apply

`apply`选项只尝试应用储藏的工作，储藏的内容仍然在栈上，要移除，用`git stash drop`。

	git stash drop stash@{0}

也可以运行`git stash pop`来重新应用储藏，同事立刻从堆栈中移走。

### 取消储藏(Un-applying a stash)
	git stash show -p stash@{0} | git apply -R

同样，没有指定，Git会选择最近的储藏

	git stash show -p | git apply -R

可以在git中增加一个stash-unapply，这样更有效率:

	git config --global alias.stash-unapply '!git stash show -p | git apply -R'
	
	git stash-unapply

### 从储藏中创建分支
	git stash branch testchanges

这是一个很棒的捷径来恢复储藏的工作然后在新的分支上继续当时的工作。

## 重写历史
“在 Git 上工作的时候，你也许会由于某种原因想要修订你的提交历史。Git 的一个卓越之处就是它允许你在最后可能的时刻再作决定。你可以在你即将提交暂存区时决定什么文件归入哪一次提交，你可以使用 stash 命令来决定你暂时搁置的工作，你可以重写已经发生的提交以使它们看起来是另外一种样子。这个包括改变提交的次序、改变说明或者修改提交中包含的文件，将提交归并、拆分或者完全删除——这一切在你尚未开始将你的工作和别人共享前都是可以的。”

### 改变最近一次提交
改变最近一次的提交说明:

	git commit --amend

也可以先进行`add`或`rm`来从新提交快照

不要在最近一次提交被推送后还去修正它，因为修正会改变提交的SHA-1值，这个很像一次非常小的rebase

### 修改多个提交说明
	git rebase -i HEAD~3

不要涵盖你已经推送的提交，这样提供了同样变更的不同版本。

很重要的一点是你得注意这些提交的顺序与你通常通过log命令看到的是相反的。

你需要修改这个脚本来让它停留在你想修改的变更上。要做到这一点，你只要将你想修改的每一次提交前面的pick改为edit。

### 重排提交
更改`pick`的顺序

### 压制(Squashing)提交

将`pick`改为`squash`

	pick f7f3f6d changed my name a bit
	squash 310154e updated README formatting and added blame
	squash a5f4a0d added cat-file

### 拆分提交
可以在`rebase -i`脚本中修改想拆分的提交前的指令为`edit`.哪里你可以用`git reset HEAD^`对那次提交进行一次混合的重置，浙江撤销那次提交并且将修改的文件撤回。此时你可以暂存并提交文件，直到你拥有多次提交，结束后，运行`git rebase --continue`。

	git reset HEAD^
	git add README
	git commit -m 'updated README'
	git add lib/simplegit.rb
	git commit -m 'added blame'
	git rebase --continue

Git在脚本中拆分中间那次，应用了最后一次提交。

**注意：所有`rebase`操作会修改SHA值，请确保不含已推送到共享仓库的提交。**

### 核弹级选项: filter-branch
修改大量提交, `filter-branch`会大面积的修改你的历史。

#### 从所有提交中删除一个文件
比如从整个历史上删除一个叫`password.txt`的文件

	git filter-brach --tree-filter 'rm -f passwords.txt' HEAD

如果你想删除所有不小心提交上去的编辑器备份文件，你可以运行类似

	git filter-branch --tree-filter "find * -type f -name '*~' -delete" HEAD

Git重写目录树并且提交，然后将分支指针移动到末尾。
一个比较好的办法是在一个测试分支上做这些，然后再`hard-reset`你的主分支
如果是在所有分支上运行`filter-branch`的话，你可以传递一个`--all`给命令

#### 将一个子目录设置为新的根目录
	git filter-branch --subdirectory-filter trunk HEAD

#### 全局性的更换电子邮件地址
	git filter-branch --commit-filter '
	        if ["$GIT_AUTHOR_EMAIL" = "schacon@localhost" ];
	        then
	            GIT_AUTHOR_NAME="Hivan Du";
	            GIT_AUTHOR_EMAIL="doo@hivan.me";
	            git commit-tree "$@";
	        else
	            git commit-tree "$@";
	        fi' HEAD

## 使用Git调试
### 文件标注
如果你发现自己的代码中的一个方法存在缺陷，你可以用`git blame`来标注文件，查看那个方法的每一行分别是由谁在那一天修改的。下面这个栗子使用了`-L`选项来限制输出范围在第12\~22行

	git blame -L 12,22 simplegit.rb

如果在`git blame`后面加上`-C`，Git会分析你在标注的文件，然后尝试找出其中代码片段的原始出处， 如果它是从其他地方拷贝过来的话。

	git blame -C -L 141,153 GITPackUpload.m

这非常有用，Git可以告诉你编写最初那些行的原始提交，即便是在另外一个文件里。

### 二分查找
如果你的状态已经经历了上百次的提交，可能就要求助于`bisect`命令了。它会在你的提交历史中进行二分查找来尽快确定哪次提交引入了错误。
首先，你运行`git bisect start`启动，然后用`git bisect bad`来告诉系统当前的提交有问题了。然后你必须告诉`bisect`已知的最后一次正常状态是哪次提交，使用`git bisect good [good_commit]`:

	git bisect start
	git bisect bad
	git bisect good v1.0
	Bisecting: 6 revisions left to test after this
	[ecb6e1bc347ccecc5f9350d878ce677feb13d3b2] error handling on repo

Git发现你标记为正常的提交(v1.0)和当前的错误版本之间有大约12次提交，于是检出中间的一个。在这里，你可以运行测试来检查问题是否存在于这次提交。如果是，那么它是在这个提交之前的某一次引入的；如果否，那么问题是在之后。架设治理是没有错误的，那么你就通过`git bisect good`来告诉Git然后继续你的旅程:
现在，你发现了提交是错误的，因此你通过`git bisect bad`来告诉Git:

	git bisect bad

这次提交是好的，Git就获得了确定问题引入位置所需的所有信息。

之后你要重设你的HEAD到你开始前的地方，否则你会处于一个诡异的地方:

	git bisect reset

这是个强大的工具，可以帮助你检查上百的提交，在几分钟内找出缺陷引入的位置。事实上，如果你有一个脚本会在工程正常时返回0，错误时返回非0的话，你可以完全自动地执行git bisect。首先你需要提供已知的错误和正确提交来告诉它二分查找的范围。你可以通过bisect start命令来列出它们，先列出已知的错误提交再列出已知的正确提交：

	$ git bisect start HEAD v1.0
	$ git bisect run test-error.sh

这样会自动地在每一个检出的提交里运行test-error.sh直到Git找出第一个破损的提交。你也可以运行像make或者make tests或者任何你所拥有的来为你执行自动化的测试。

## 子模块
子模块允许你将一个 Git 仓库当作另外一个Git仓库的子目录。这允许你克隆另外一个仓库到你的项目中并且保持你的提交相对独立。

### 子模块初步
假如想把`Rack`(一个Ruby的web服务器网关借口)库加入到你的项目中，可能既要保持你自己的变更，又要延续上游的变更。首先要把外部的仓库克隆到你的子目录中，通过`git submodule add`将外部项目加为子模块:

	git submodule add git://github.com/chneukirchen/rack.git rack

项目里`rack`子目录下有了一个Rack项目

	git status

会注意到有一个`.gitmodules`文件,这是一个配置文件，保存了项目URL和你拉取到本地子目录

	cat .gitmodules
	[submodule "rack"]
	        path = rack
	        url = git://github.com/chneukirchen/rack.git

另外一项是`rack`
如果运行在那上面运行`git diff`，会看到:

	$ git diff --cached rack
	diff --git a/rack b/rack
	new file mode 160000
	index 0000000..08d709f
	--- /dev/null
	+++ b/rack
	@@ -0,0 +1 @@
	+Subproject commit 08d709f78b8c5b0fbeb7821e37fa53e69afcf433

关于子模块的重要一点:你记录他们当前确切所处的提交。你不能记录一个子模块的`master`或者其他的符号引用。

当提交时，会看到类似下面的:

	git ci -a -m 'git submodule add'
	[develop dfc89b3] git submodule add
	 3 files changed, 18 insertions(+)
	 create mode 100644 .gitmodules
	 create mode 160000 rack

### 克隆一个带子模块的项目
你将得到包含子项目的目录，但是没有文件:

	git clone git://github.com/schacon/myproject.git

这个时候`rock`目录存在了，但是是空的。这个时候必须运行两个命令:
- 初始化本地配置文件

		git submodule init

- 从项目拉去所有数据并检出你上层项目里所列的合适的提交:

		git submodule update

现在`rack`子目录就处于先前提交的确切状态了。

如果另外一个开发者变更了`rack`的代码，你拉去的那个引用然后归并之，将得到怪异的东西。

	git merge origin/master
	Updating 0550271..85a3eee
	Fast forward
	 rack |    2 +-
	 1 files changed, 1 insertions(+), 1 deletions(-)
	[master*]$ git status
	# On branch master
	# Changes not staged for commit:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	#      modified:   rack
	#

你归并来的仅仅上是一个指向你的子模块的指针；但是它并不更新你子模块目录里的代码，所以看起来你的工作目录处于一个临时状态:

	git diff
	diff --git a/rack b/rack
	index 6c5e70b..08d709f 160000
	--- a/rack
	+++ b/rack
	@@ -1 +1 @@
	-Subproject commit 6c5e70b984a60b3cecd395edd5b48a7575bf58e0
	+Subproject commit 08d709f78b8c5b0fbeb7821e37fa53e69afcf433

因为你所拥有的指向子模块的指针和子模块的目录的真实状态并不匹配，为了修复，你必须再次运行`git submodule update`

当开发者对子模块做了一个本地变更没有推送。然后他们提交了一个指向那个非公开状态的指针然后推送上层项目。当其他开发者运行`git submodule update`，子模块系统会找不到所引用的提交，因为它值存在于第一个开发者的系统中。

	git submodule update
	fatal: reference isn’t a tree: 6c5e70b984a60b3cecd395edd5b48a7575bf58e0
	Unable to checkout '6c5e70b984a60b3cecd395edd5ba7575bf58e0' in submodule path 'rack'

就不得不去查看谁最后变更了子模块

	git log -1 rack

然后发个邮件给那个家伙: \**f\*\*k u!* 
### 上层项目
“有时候，开发者想按照他们的分组获取一个大项目的子目录的子集。如果你是从 CVS 或者 Subversion 迁移过来的话这个很常见，在那些系统中你已经定义了一个模块或者子目录的集合，而你想延续这种类型的工作流程。

**在 Git 中实现这个的一个好办法是你将每一个子目录都做成独立的 Git 仓库，然后创建一个上层项目的 Git 仓库包含多个子模块。**这个办法的一个优势是你可以在上层项目中通过标签和分支更为明确地定义项目之间的关系。”

摘录来自: Andor Chen. “精通 Git”。 iBooks. 

### 子模块的问题
执行`git submodule update`，然后在子模块目录里不创建分支就进行提交，然后再次从上层项目里运行`git submodule update`同时不进行提交，Git会毫无提示的覆盖你的变更。

为了避免，在子模块工作时应该创建一个分支`git checkout -b work`,当再次在子模块里更新的时候，仍然会覆盖你的工作，但是至少你拥有一个可以回溯的指针。

如果你创建了一个分支增加了子模块，然后切回不带该子模块的分支，仍然会拥有一个未被追踪的子模块的目录。

	git checkout -b rack
	git submodule add git@github.com:schacon/rack.git rack
	git commit -am 'add rack submodule'
	git checkout master
	git status

最后，如果你跟踪了项目中的一些文件，想把他们移动到子模块去，你必须非常小心。

假如你项目里有一个子目录里放了`rack`的文件，然后你想把它转换为子模块。如果你删除了子目录然后运行`submodule add`:

	rm -rf rack/
	git submodule add git@github.com:schacon/rack.git rack
	'rack' already exists in the index
  
你必须先将`rack`目录撤回，然后才能加入子模块:

	git rm -r rack
	git submodule add git@github.com:schacon/rack.git rack

现在假设你在一个分支里那样做了。如果你尝试切换回一个仍然在目录里保留那些文件而不是子模块的分支时——你会得到下面的错误：

	$ git checkout master
	error: Untracked working tree file 'rack/AUTHORS' would be overwritten by merge.

你必须先移除rack子模块的目录才能切换到不包含它的分支：

	$ mv rack /tmp/
	$ git checkout master
	Switched to branch "master"
	$ ls
	README  rack

然后，当你切换回来，你会得到一个空的rack目录。你可以运行git submodule update重新克隆，也可以将/tmp/rack目录重新移回空目录。

### 子树合并
子树归并是拥有两个工程，其中一个映射到另外一个项目的子目录。当指定一个子树归并，Git会探知其中一个是另外一个的子树从而实现正确的归并。

首先，你将`Rack`应用假如到项目中。你将`Rack`项目当作你项目中的一个远程引用，然后将它检出到自身的分支:

	git remote add rack_remote git@github.com:schacon/rack.git
	git fetch rack_remote
	git checkout -b rack_branch rack_remote/master

然后拉取`rack_branch`到你的主项目的`master`分支的`rack`子目录:

	git read-tree --prefix=rack/ -u rack_branch

然后可以直接拉取来获得上游的变更

	git checkout rack_branch
	git pull

之后…

	git checkout master
	git merge --squash -s subtree --no-commit rack_branch

`git merge -s subtree`归并变更回`master`分支，为了预置提交说明，需要同时使用`--squash`和`--no-commit`选项


为了得到`rack`子目录和你`rack_branch`分支的区别———以决定你是否需要归并，你不能使用一般的`diff`命令。而是对你想比较的分支运行`git diff-tree`:

	git diff-tree -p rack_branch

或者，为了比较你的`rack`子目录和服务器上你拉取时的`master`分支，你可以:

	git diff-tree -p rack_remote/master

# 自定义Git
## 配置Git
	git config --global user.name "Hivan Du"
	git config --global user.email doo@hivan.me

### 客户端基本配置
	git config --help
	
	code.editor

可以改变默认编辑器

	git config --global core.editor sm -w
	
	commit.template

提交的时候，Git会默认使用该文件定义的内容。
Ex: 你创建了一个模板文件`$HOME/.gitmessage.txt`:

	subject line
	what happened
	[ticket: X]
	
	git config --global commit.template
	$HOME/.gitmessage.txt
	git commit

提交的时候，编辑器中显示的提交信息如下:

> subject line
> 
> what happened
> 
> [ticket: X]
> # Please enter the commit message for your changes.
> Lines starting

如果有特定的策略要运用在提交信息上，系统上创建一个模板文件，设置Git默认使用它，这样当提交时，你的策略每次都会被运用。

	core.paper
这个指定Git运行诸如`log`,`diff`等所使用的分页器，你能设置成用`more`或者任何你喜欢的分页器（默认是less), 当然你也可以什么都不用，设置空字符串:

	git config --global core.paper "
	
	user.signingkey

如果你要创建经签署的含附注的标签，那么把你的GPG签署密钥设置为配置项会更好，设置密钥ID如下:

	git config --global user.signingkey <gpg-key-id>

PS: 关于gpg公钥的作用，是为了不让其他开发者随意修改代码而设置的。
如这里: [http://airk000.github.io/git/2013/09/30/git-tag-with-gpg-key][8]

`core.excludesfile`

如果你想在项目库之外的文件来定义那些需要被忽略的文件的画，用`core.excludesfile`通知Git该文件所处的位置，文件内容和`.gitignore`类似

`help.autocorrect`

该配置项只在Git 1.6.1及以上版本有效，假如你在Git1.6中错打了一条命令，会显示:

	git com
	git: 'com' is not a git command. See 'git --help'.
	
	Did you mean one of these?
	    commit
	    co
	    column

如果把`help.autocorrect`设置成`1`（启用自动修正），那在只有一个命令被模糊匹配到的情况下，Git会自动运行该命令。

### Git中的着色
`color.ui`设置为`true`来打开所有的默认终端着色

	git config --global color.ui true

另外还有`false`和`always`命令，大多数情况下，大多数情况下，你如果想被重定向的输出中插入颜色码，你能传递`--color`标志给Git命令来迫使它这么做，`color.ui=true`应该是首选

`color.*`
想要具体到哪些命令输出需要被着色以及怎样着色或者 Git 的版本很老，你就要用到和具体命令有关的颜色配置选项，它们都能被置为`true`、`false`或`always`：

	color.branch
	color.diff
	color.interactive
	color.status

每个选项都有子选项，可以用来覆盖其父设置，以大道为输出的各个部分着色的目的。
Ex: 让`diff`输出的改变信息以粗体，蓝色前景和黑色背景的形式显示:

	git config --global color.diff.meta "blue black bold"

你能设置的颜色值如：normal、black、red、green、yellow、blue、magenta、cyan、white，正如以上例子设置的粗体属性，想要设置字体属性的话，可以选择如：bold、dim、ul、blink、reverse。

如果你想配置子选项的话，可以参考git config帮助页。

### 外部的合并与比较工具
下载**P4Merge:**:
http://www.perforce.com/perforce/downloads/component.html

首先把你要运行的命令放入外部包装脚本中，我会使用Mac系统上的路径来指定该脚本的位置，在其他系统上，它应该被放置在二进制文件p4merge所在的目录中。创建一个merge包装脚本，名字叫作extMerge，让它带参数调用p4merge二进制文件

	cat /usr/local/bin/extMerge
	#!/bin/sh
	/Applications/p4merge.app/Contents/MacOS/p4merge $*

`diff`包装脚本首先确定传递过来7个参数，然后把其中两个传递给`merge`包装脚本，默认情况下，Git传递以下参数给`diff`:

	path old-file old-hex old-mode new-file new-hex new-mod

由于你仅仅需要`old-file`和`new-file`参数，用`diff`包装脚本来传递它们把。

	cat /usr/local/bin/extDiff
	#!/bin/sh
	[ $# -eq 7 ] && /usr/local/bin/extMerge "$2" "$5"

确认这两个脚本是可执行的：

	sudo chmod +x /usr/local/bin/extMerge
	sudo chmod +x /usr/local/bin/extDiff

现在来配置使用自定义比较和合并工具。这需要许多自定义设置: 
- `merge.tool`通知Git使用哪个合并工具; 
- `mergetool.*.cmd`规定命令运行的方式; 
- `mergetool.trustExitCode`会通知Git程序的推出是否只是合并操作成功; 
- `diff.external`通知Git用什么命令做比较。
因此，你能运行以下4条配置命令:

	$ git config --global merge.tool extMerge
	$ git config --global mergetool.extMerge.cmd \
	    'extMerge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'
	$ git config --global mergetool.trustExitCode false
	$ git config --global diff.external extDiff

或者直接编辑`~/.gitconfig`文件如下:

	[merge]
	  tool = extMerge
	[mergetool "extMerge"]
	  cmd = extMerge \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\"
	  trustExitCode = false
	[diff]
	  external = extDiff

设置完毕后，运行`diff`命令:

	git diff 

当合并两个分支，有冲突的时候，运行`git mergetool`，会调用P4Merge。

设置包装脚本的好处是你能简单的改变diff和merge工具，例如把`extDiff`和`extMerge`改成`KDiff3`,要做的仅仅是编辑`extMerge`脚本:

	cat /usr/local/bin/extMerge
	#!/bin/sh
	/Applications/kdiff3.app/Contents/MacOS/kdiff3 $*

现在Git使用`KDiff3`来比较合并了。

Git预置了许多其他工具:
- kdiff3
- opendiff
- tkdiff
- meld
- xxdiff
- emerge
- vimdiff
- gvimdiff
如果不想用到KDiff3的所有功能，只是用来合并，那么kdiff3正符合要求:

	git config --global merge.tool kdiff3

### 格式化与空白

	core.autocrlf

如果是Windows上，将这项设置为`true`，这样当签出代码时候，`LF`会被转换成`CRLF`:

	git config --global core.autocrlf true

Linux或Mac使用`LF`作为行结束符，因此不想Git签出文件时进行转换；当一个以`CRLF`为行结束符的文件不小心被引入时你肯定想进行修正，把`core.autocrlf`设置成`input`来告诉Git在提交时把`CRLF`转换成`LF`，签出时不转换:

	git config --global core.autocrlf input

这样会在Windows上签出文件中保留CRLF，在Mac和Linux上，包括仓库中保留`LF`

如果Windows上开发仅在Windows上运行的项目，可以`false`取消这项功能。

`core.whitespace`

Git预置了探测和修正空白问题的选项
默认被打开的是`trailing-space`和`space-before-tab`
前者会查找每行结尾的空格，后者会查找每行开头的制表符前的空格。

默认关闭的是`indent-with-non-tab`和`cr-at-eol`;
前者会炒找8个以上空格（不是制表符）开头的行，后者让Git知道行尾回车符是合法的。

如果你想打开除了`cr-at-eol`之外的所有选项:

	git config --global core.whitespace \ trailing-space, space-before-tab, indet-with-non-tab

如果整准备运用的补丁有特别的空白问题，可以让Git发警告:

	git apply --whitespace=warn <patch>

或者让Git打补丁前自动修正此问题

	git apply --whitespace=fix <patch>

y也能运用于衍合。如果提交了有空白问题的文件但是还没有推送到上流，你可以运行带有`--whitespace=fix`选项的`rebase`来让Git在重写补丁时自动修正它们。

### 服务器端配置
`receive.fsckObjects`

强迫Git每次推送都检查SHA-1一致性

	git config --system receive.fsckObjects true

`receive.denyNonFastForwards`

禁用强制更新功能:

	git config --system receive.denyNonFastForwards true

`receive.denyDeletes`

规避`denyNonFastForwards`策略的方法之一就是用户删除分支，然后推回新的引用。在更新的Git版本中，`receive.denyDeletes`设置为`true`

	git config --system receive.denyDeletes true

这样会在推送过程中阻止删除分支和标签 \-\- 没有用户能够这么做。要删除远程分支，必须从服务器手动删除引用文件。通过用户访问控制列表也能这么做，在本章结尾将会介绍这些有趣的方式。

## Git属性
一些设置项也能被运用于特定的路径中，这样，Git以对一个特定的子目录或子文件集运用那些设置项。这些设置项被成为Git属性，可以在目录中的`.gitattributes`文件内进行设置（通常是项目的根目录），也可以当你不想让这些属性文件和项目文件一通提交时，在`.git/info/attributes`进行设置。

使用属性，你可以对个别文件或目录定义不同的合并策略，让 Git 知道怎样比较非文本文件，在你提交或签出前让 Git 过滤内容。你将在这部分了解到能在自己的项目中使用的属性，以及一些实例。

### 二进制文件

#### 识别二进制文件
让Git把所有`pbxproj`文件当成二进制文件，在`.gitattributes`文件中设置如下:

	*.pbxproj -crlf -diff

现在，Git会尝试转换和修正`CRLF`问题，也不 会当你在项目中运行`git show`或`git diff`时，比较不同的内容。在Git1.6之后，可以用一个宏代替`-crlf -diff`:

	*.pbxproj binary

#### 比较二进制文件
`MS Word files`

Git属性能很好的解决比较两个不同版本的Word文件，把下面的行加到`.gitattributes`

	*.doc diff=word

`word过滤器`市集就是Git使用`Strings`程序，把word文档转换成可读的文本文件，之后再进行比较:

	git config diff.word.textconv catdoc

这个命令会在你的`.git/config`文件中增加一节:

	[diff"word"]
	        textconv = catdoc

如果两个快照之间比较以`.doc`结尾的文件，Git对这些文件运用`word过滤器`。在比较钱把word文件转换成文本文件。

还能用这个方法比较图像文件。

	echo '*.png diff=exif' >> .gitattributes
	git config diff.exif.textconv exiftool

### 关键字扩展
Git无法在一个文件提交后修改它，因为Git会对改文件计算校检和。然而，你可以在签出时注入文本，在提交前删除它。Git属性提供了2种方式这么做。

能把`blob`的SHA-1校检和自动注入文件的`$Id$`字段。
如果在一个或多个文件上设置了此字段，当下次签出分支的时候，Git用`blob`的SHA-1值替换。**注意，这不是提交对象的SHA校检和，而是`blob`本身的校检和**

	echo '*.txt ident' >> .gitattributes
	echo '$Id$' > test.txt

下次签出文件时，Git入了`blob`的SHA值

	rm test.txt
	git checkout -- test.txt
	cat test.txt
	Id: 42812b7653c7b88933f8a9d6cad0ca16714b9bb3 $
 
你能写自己的过滤器，在提交文件到暂存区或签出文件时替换关键字。
有两种过滤器: `clean`和`smudge`，在`.gitattributes`文件中，你能对特定的路径设置一个过滤器，然后设置处理文件的脚本，这些脚本会在文件签出前(`smudge`)和提交到暂存区前(“`clean`”)被调用。这些过滤器能做各种有趣的事情。

Ex: 暂存前，用`indent`程序过滤所有C源代码，在`.gitattributes`文件中设置`indent`过滤器过滤`*.c`文件：

	*.c  filter=indent

然后，配置Git让其知道`indent`过滤器在遇到`smudge`和`clean`时分别改做什么

	git config --global filter.indent.clean indent
	git config --global filter.indent.smudge cat

于是，暂存`*.c`文件时，`indent`程序会被触发，在把他们签出之前，cat程序会被触发。但cat程序在这里没有什么实际作用。这样的组合，使C源代码在暂存前被`indent`程序过滤，非常有效。

Ex2: 类似RCS的`$Date$`关键字扩展。为了演示，需要一个小脚本，接受文件名参数，得到项目的最新提交日期，最后把日期写入该文件。下面用`Ruby`脚本来实现:

	#!/usr/bin/env ruby
	data = STDIN.read
	last_date = `git log --pretty=format:"%ad" -1`
	puts data.gsub('$Date$', '$Date:' + last_date.to_s + '$')

保存脚本为`expand_date`, 然后在Git设置一个过滤器，让它签出文件时调用`expand_date`,在暂存文件时用Perl清楚之：

	git config filter.dater.smudge expand_date
	git config filter.dater.clean 'perl -pe "s/\\\$Date[^\\\$]*\\\$/\\\$Date\\\$/"'

这段程序会删除`$Date$`字符串中多余的字符，恢复`$Date$`原貌。

	echo '# $Date$' > date_test.txt
	echo 'date*.txt filter=dater' >> .gitattributes

暂存该文件，之后签出，你会发现关键字被替换了:

	git add date_test.txt .gitattributes
	git commit -m "Testing date expansion in Git"
	rm date_test.txt
	git checkout date_test.txt
	cat date_test.txt
	$Date: Tue Apr 21 07:26:52 2009 -0700$

**PS:没有测试成功**

虽说这项技术对自定义应用来说很有用，但还是要小心，因为`.gitattributes`文件会随着项目一起提交，而过滤器（例如：`dater`）不会，所以，过滤器不会在所有地方都生效。当你在设计这些过滤器时要注意，即使它们无法正常工作，也要让整个项目运作下去。

### 导出仓库
Git属性在导出项目归档时也能发挥作用。

`export-ignore`

当产生一个归档，可以设置Git不导出某些文件和目录。

如果你不想在归档包含它们，但是想纳入项目的版本管理，能对应的设置`export-ignore`属性

Ex: 在`test/`子目录中有一些测试文件，在项目的压缩包中包含它们是没有意义的。

设置如下到Git属性文件：

	test/ export-ignore

现在，运行`git archive`来创建项目压缩包时，那个目录不会在归档中出现

	export-subst

还能对归档做一些简单的关键字替换。

可以以`--pretty=format`形式的简码在任何文件中放入`$Format:$`字符串。例如，想在项目中包含一个叫`LAST_COMMIT`的文件，当运行`git archive`时，最后提交日期自动注入该文件，可以这样设置:

	echo 'Last commit date:$Format:%cd$' > LAST_COMMIT
	echo "LAST_COMMIT export-subst" >> .gitattributes
	git add LAST_COMMIT .gitattributes
	git commit -am 'adding LAST_COMMIT file for archives'

**PS: 测试不成功！**

### 合并策略
Ex: 你有一个数据库设置文件`database.xml`，两个分支中不同，想合并一个分支到另一个，而不弄乱该数据库文件，可以设置属性如下：

	database.xml merge=ours

如果合并到另外一个分支，database.xml文件不会有合并冲突，显示如下:

	git merge develop
	Auto-merging database.xml
	Merge made by recursive.

这样，`database.xml`会保持原样。

## Git 挂钩
主要有客户端和服务器端两组。

### 安装一个挂钩
挂钩被存储在`hooks/`子目录下，即大部分项目中的`.git/hooks`。

### 客户端挂钩
- 提交工作流挂钩
- 电子邮件工作流挂钩
- 其他客户端挂钩

#### 提交工作流挂钩
有4个挂钩被用来处理提交的过程
- `pre-commit`在键入提交信息前运行，用来检查即将提交的快照。当从该挂钩返回非零值时，Git放弃此次提交，但是可以用`git commit --no-verify`来忽略。
- `prepare-commit-msg`挂钩在提交信息编辑器显示之前，默认信息被创建之后运行。可以和提交模板配合使用，以变成的额方式插入信息。
- `commit-msg`挂钩接收一个参数，此参数是包含最近提交信息的临时文件的路径。
- `post-commit`挂钩在整个提交过程完成后运行，他不会接收任何参数，但可以运行`git log -l HEAD`来获得最后的提交信息。通知之类使用的。

#### Email工作流挂钩
当运行`git am`命令，会调用。
- `applypatch-msg`，接收一个参数:包含被建议提交信息的临时文件名。确认提交信息是否被正确格式化，或让脚本编辑信息以达到标准化。
- `pre-applypatch`不接收参数，补丁运用之后运行。可以用来在提交前检查快照。
- `post-applypatch`你可以用它来通知一个小组或获取的补丁的作者，淡无法组织打补丁的过程。

#### 其他客户端挂钩
`pre-rebase`在衍合前运行，脚本以非零推出可以中止衍合的过程。可以用这个挂钩来禁止已经推送的提交对象。

### 服务器端挂钩

**以后部署服务器的时候再看**

#### update

## Git强制策略实例
在本节中，我们应用前面学到的知识建立这样一个Git 工作流程：检查提交信息的格式，只接受纯fast-forward内容的推送，并且指定用户只能修改项目中的特定子目录。我们将写一个客户端脚本来提示开发人员他们推送的内容是否会被拒绝，以及一个服务端脚本来实际执行这些策略。

### 服务器端挂钩
服务器端的工作都在hooks目录的update脚本中指定。

### 客户端挂钩


**关于Git的服务器部署和挂钩，以后再慢慢学**

# Git与其他系统
## Git 与 Subversion
#### git svn
Git 中所有 Subversion 桥接命令的基础是 git svn 。所有的命令都从它开始。相关的命令数目不少，你将通过几个简单的工作流程了解到其中常见的一些。

值得警戒的是，在使用 git svn 的时候，你实际是在与 Subversion 交互，Git 比它要高级复杂的多。尽管可以在本地随意的进行分支和合并，最好还是通过衍合保持线性的提交历史，尽量避免类似与远程 Git 仓库动态交互这样的操作。

避免修改历史再重新推送的做法，也不要同时推送到并行的 Git 仓库来试图与其他 Git 用户合作。Subersion 只能保存单一的线性提交历史，一不小心就会被搞糊涂。合作团队中同时有人用 SVN 和 Git，一定要确保所有人都使用 SVN 服务来协作。

**2015-1-19 update: Git-Svn部分稍后学习。 如果之后学习，此部分将会更新，并写入更新日期。**

### 初始设定

### 入门

### 提交到Subversion

### 拉取最新进展

### Git分支问题

### Subversion分支

### 切换当前分支

### 对应Subversion的命令
#### SVN 风格的历史

#### SVN日志

#### SVN服务器信息

#### 略Subversion之所略

### Git-Svn总结

## 迁移到Git
### 导入
### Subversion
### 自定义导入脚本

# Git内部原理
Git从根本是一套内容寻址（content-addressable)文件系统，在此之上提供了一个VCS用户界面。

## 底层命令（Plumbing）和高层命令(Porcelain)
`.git`目录

	cd .git/
	ls
	HEAD
	branches/
	config
	description
	hooks/
	index
	info/
	objects/
	refs/

该目录下有可能还有其他文件，但这是一个全新的 `git init` 生成的库，所以默认情况下这些就是你能看到的结构。新版本的 Git 不再使用 `branches` 目录，`description` 文件仅供 GitWeb 程序使用，所以不用关心这些内容。`config` 文件包含了项目特有的配置选项，`info` 目录保存了一份不希望在 `.gitignore` 文件中管理的忽略模式 (ignored patterns) 的全局可执行文件。`hooks` 目录保存了第七章详细介绍了的客户端或服务端钩子脚本。

另外还有四个重要的文件或目录：`HEAD` 及 `index` 文件，`objects` 及 `refs` 目录。这些是 Git 的核心部分。`objects` 目录存储所有数据内容，`refs` 目录存储指向数据 (分支) 的提交对象的指针，`HEAD` 文件指向当前分支，`index` 文件保存了暂存区域信息。

## Git对象
Git从核心上来看不过是简单地存储键值对(key-value) 。允许插入任意类型的内容，并返回一个键值，通过该键值可以在任何时候再取出该内容。

	$ mkdir test
	$ cd test
	$ git init
	$ find .git/objects
	.git/objects
	.git/objects/info
	.git/objects/pack
	$ find .git/objects -type f

Git初始化了`objects`目录，并创建了`pack`和`info`子目录，但是该目录下没有其他常规文件。我们往这个Git数据库里存储一些文本:

	echo 'test content' | git hash-object -w --stdin
	d670460b4b4aece5915caf5c68d12f560a9fe3e4

参数`-w`指示`hash-object`命令存储（数据）对象，若不指定这个参数该命令仅仅返回键值。`--stadin`指定从标准输入设备(stdin)来读取内容，若不指定这个参数则需指定一个要存储的文件的路径。该命令输出长度为40个字符的校检和。这是个SHA-1哈希值\-\-其值为要存储的数据加上你马上会了解到的一种头信息的校检和。

现在可以查看到Git已经存储了数据:

	$ find .git/objects -type f
	.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4

Git存储数据的方式: 为每份内容生成一个文件，取得该内容与头信息的SHA-1校检和，创建以该校验和前两个字符为名称的子目录，并以（校验和）剩下38个字符为文件命名（保存至子目录下）。

通过`cat-file`命令可以将数据内容取回。

	$ git cat-file -p d670460b4b4aece5915caf5c68d12f560a9fe3e4
	test content

新可以往Git中添加更多内容并取回，也可以直接添加文件。

	$ echo 'version 1' > test.txt
	$ git hash-object -w test.txt
	83baae61804e65cc73a7201a7252750c76066a30
	
	$ echo 'version 2' > test.txt
	$ git hash-object -w test.txt
	1f7a7a472abf3dd9643fd615f6da379c4acb3e3a
	
	$ find .git/objects -type f
	.git/objects/.DS_Store
	.git/objects/1f/7a7a472abf3dd9643fd615f6da379c4acb3e3a
	.git/objects/83/baae61804e65cc73a7201a7252750c76066a30
	.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4

将文件恢复到第一个版本

	$ git cat-file -p 83baae61804e65cc73a7201a7252750c76066a30 > test.txt
	$ cat test.txt
	version 1

或者恢复到第二个版本

	$ git cat-file -p 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a

需要记住的是几个版本的文件 SHA-1 值可能与实际的值不同，其次，存储的并不是文件名而仅仅是文件内容。这种对象类型称为 `blob` 。通过传递 SHA-1 值给 `cat-file -t` 命令可以让 Git 返回任何对象的类型：

	$ git cat-file -t 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a
	blob

### tree对象
接下去来看 tree 对象，tree 对象可以存储文件名，同时也允许存储一组文件。

	$ git cat-file -p master^{tree}
	100644 blob a906cb2a4a904a152e80877d4088654daad0c859      README
	100644 blob 8f94139338f9404f26296befa88755fc2598c289      Rakefile
	040000 tree 99f1a6d12cb4b6f19c8655fca46c3ecf317074e0      lib

`master^{tree}`表示branch分支上最新提交指向的tree对象。请注意`lib`子目录并非一个`blob`对象，而是一个指向另一个`tree`对象的指针:

![]\(images/pic-9-1.png)
























[1]:	http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US
[4]:	http://www.kaleidoscopeapp.com/ksdiff
[5]:	https://tommcfarlin.com/kaleidoscope-git-diff-tool/
[6]:	http://github.com/guides/providing-your-ssh-key
[7]:	https://git.wiki.kernel.org/index.php/GitHosting
[8]:	http://airk000.github.io/git/2013/09/30/git-tag-with-gpg-key

[image-1]:	images/git_tree.jpg
