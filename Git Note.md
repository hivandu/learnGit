
# Git 基础
## 文本编辑器
`git config —global core.editor sm`

## 差异分析工具
`git config —global merge.tool vimdiff`
“Git 可以理解 kdiff3，tkdiff，meld，xxdiff，emerge，vimdiff，gvimdiff，ecmerge，和 opendiff 等合并工具的输出信息。”

## 查看配置信息
`git config —list`
ex: `git config user.name`

# 取得项目的Git仓库
## 初始化新仓库
	git init
	git add *.c
	git add README
	git commit -m 'initial project version'

## 克隆现有仓库
	git clone git://github.com/xxxxx/xxx.git
	git clone git://github.com/xxxxx/xxx.git xxxx.git

## 记录每次更新到仓库
- untracked
- unmodified
- modified
- staged
## 检查当前文件状态
	git status

## 跟踪新文件
	git add README

## 暂存已修改文件
	git add xxxxxx.md
> “译注：其实 git add 的潜台词就是把目标文件快照放入暂存区域，也就是 add file into staged area，同时未曾跟踪过的文件标记为需要跟踪。这样就好理解后续 add 操作的实际意义了。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 

## 忽略某些文件
	cat .gitignore
需要修改`.gitignore`，
规范格式如下:
- “所有空行或者以注释符号 ＃ 开头的行都会被 Git 忽略。
- 可以使用标准的 glob 模式匹配。
- 匹配模式最后跟反斜杠（/）说明要忽略的是目录。
- 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。”
> “所谓的 glob 模式是指 shell 所使用的简化了的正则表达式。星号（\*）匹配零个或多个任意字符；[abc]() 匹配任何一个列在方括号中的字符（这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）；问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配（比如 [0-9]() 表示匹配所有 0 到 9 的数字）。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 
ex:
	“# 此为注释 – 将被 Git 忽略
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
	doc/**/*.txt”
>  摘录来自: Andor Chen. “精通 Git”。 iBooks. 

## 查看已经暂存和未暂存的更新
	git status

查看尚未暂存的文件更新哪些部分，不加参数直接输入`git diff`
**“此命令比较的是工作目录中当前文件和暂存区域快照之间的差异，也就是修改之后还没有暂存起来的变化内容。”**

查看已经暂存的文件和上次提交的快照之间的差异:
	git diff --cached(--staged)

## 提交更新
	git commit
一半都是`VIM`，可以更改默认editor
或者直接参加参数`git commit -m "want change editor"`
or `git commit -a -m "want change editor"`来跳过git add 步骤

## 移除文件
- 从文件目录中删除
	`git rm delfile.md`
- 从仓库删除（亦从暂存区域删除）
	`git rm --cached delfile.md`
- 也可以使用`glob`模式
	`git rm log/\*.log`

## 移动文件
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

## 限制输出长度
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

## 图形化工具
	gitk

# 撤销操作
## 修改最后一次提交
	git commit --amend

## 取消已经暂存的文件
	git reset HEAD README.md

## 取消对文件的修改
	git checkout -- README.md

> “记住，任何已经提交到 Git 的都可以被恢复。即便在已经删除的分支中的提交，或者用 --amend 重新改写的提交，都可以被恢复（关于数据恢复的内容见第九章）。所以，你可能失去的数据，仅限于没有提交过的，对 Git 来说它们就像从未存在过一样。”
> 摘录来自: Andor Chen. “精通 Git”。 iBooks. 

# 远程仓库的使用
## 查看当前的远程库
	git remote
也可以加上`-v`(—verbose)，显示对应的克隆地址
	git remote -v

## 添加远程仓库
	git remote add [shortname] [url]
ex: `git remote add test git@gitcafe.com:hivandu/LearnGit.git`

现在可以用字符串`test`纸袋对应的仓库地址了，比如说，要抓取所有的gitcafe有的，但是本地仓库没有的信息，可以运行`git fetch test`
gitcafe上的主分支master已经完全可以在本地访问了，对应的名字是`test/master`，可以合并到自己的某个分支，或者切换到这个分支。

## 从远程仓库抓取数据
	git fetch [remote-name]

如果clone了一个仓库，此命令会自动将远程仓库归于`origin`名下，所以，`git fetch origin`会抓取从你上次克隆以来别人上传到此仓库中的所有更新。**`fetch`命令只是将远端的数据拉到本地仓库，并不自动合并到当前工作分支，只有当确实准备好了，才能手工合并。**

如果设置了某个分支用于跟踪某个远端仓库的分支，可以使用`git pull`自动抓取数据下来，然后将远端分支自动合并到本地仓库中的当前分支。

一般我们运行`git pull`,目的都是要从原始克隆的远端仓库中抓取数据后，合并到工作目录中的当前分支。

## 推送到远程仓库
	git push [remote-name] [branch-name]
ex : `git push origin master`

## 查看远程仓库信息
	git remote show [remote-name]
ex: `git remote show origin`

## 远程仓库的删除和重命名
	git remote rename test paul
	git remote rm paul
 

# 打标签
## 列显示已有的标签
	git tag
	git tag -l 'v1.4.2'

## 新建标签
Git有两种标签类型: 轻量级的`lightweight` 和 附注的`annotated`。
### 含附注的标签
	git tag -a v1.1 -m 'my version 1.1'

可以使用`git show`来查看相应标签的版本信息。
	git show v1.1
## 部署标签
如果有自己的私钥，还可以用GPG来签署标签，只需要把之前的`-a`改为`-s`(signed)即可:
	git tag -s v1.2 -m 'my signed 1.2 tag'
**在Mac内必须想要安装gpgtool**: `brew install gpg`

## 轻量级标签
就是一个保存着对应提交对象的校检和信息的文件。一个`-a`,`-s`,`-m`都不要用。直接给出标签名字
	git tag v1.3-lw

## 验证标签
	git tag -v [tag-name]

## 后期加注标签
打标签的时候跟上对应提交对象的校验
	git tag -a v1.0 8f3e6e

## 分享标签
	git push origin [tagname]
ex: `git push origin v1.0`
或一次推送所有标签
	git push origin --tags

## 技巧和窍门
### 自动补全
如果你用的是 Bash shell，可以试试看 Git 提供的自动补全脚本。下载 Git 的源代码，进入 contrib/completion 目录，会看到一个 git-completion.bash 文件。将此文件复制到你自己的用户主目录中（译注：按照下面的示例，还应改名加上点：`cp git-completion.bash ~/.git-completion.bash）`，并把下面一行内容添加到你的 .bashrc 文件中：
	source ~/.git-completion.bash
“也可以为系统上所有用户都设置默认使用此脚本。Mac 上将此脚本复制到 `/opt/local/etc/bash_completion.d` 目录中，Linux 上则复制到 `/etc/bash_completion.d/` 目录中。这两处目录中的脚本，都会在 Bash 启动时自动加载。”
“在输入 Git 命令的时候可以敲两次跳格键（Tab），就会看到列出所有匹配的可用命令建议：”
	git co<tab><tab>
	commit config
摘录来自: Andor Chen. “精通 Git”。 iBooks. 

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

