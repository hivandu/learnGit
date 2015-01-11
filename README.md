# Here is Git learn
> If I change something, I must save it to git cache.

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
> “所谓的 glob 模式是指 shell 所使用的简化了的正则表达式。星号（*）匹配零个或多个任意字符；[abc]() 匹配任何一个列在方括号中的字符（这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）；问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配（比如 [0-9]() 表示匹配所有 0 到 9 的数字）。”
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

选项	 说明
%H	提交对象（commit）的完整哈希字串
%h	提交对象的简短哈希字串”
%T	树对象（tree）的完整哈希字串
%t	树对象的简短哈希字串
%P	父对象（parent）的完整哈希字串
%p	父对象的简短哈希字串
%an	作者（author）的名字
%ae	作者的电子邮件地址
%ad	作者修订日期（可以用 -date= 选项定制格式）
%ar	作者修订日期，按多久以前的方式显示
%cn	提交者(committer)的名字
%ce	提交者的电子邮件地址
%cd	提交日期
%cr	提交日期，按多久以前的方式显示
%s	提交说明”

- 结合`--graph`选项，可以看到开头多出一些ASCII字符串表示的简单图形。展示每个提交所在的分支及其分化衍合情况。
		git log --pretty=format:"%h %s" --graph

选项	说明
-p	按补丁格式显示每个更新之间的差异。
--word-diff	按 word diff 格式显示差异。
--stat	显示每次更新的文件修改统计信息。
--shortstat	只显示 --stat 中最后的行数修改添加移除统计。
--name-only	仅在提交信息后显示已修改的文件清单。
--name-status	显示新增、修改、删除的文件清单。
--abbrev-commit	仅显示 SHA-1 的前几个字符，而非所有的 40 个字符。
--relative-date	使用较短的相对时间显示（比如，“2 weeks ago”）。
--graph	显示 ASCII 图形表示的分支合并历史。
--pretty	使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（后跟指定格式）。
--oneline	`--pretty=oneline --abbrev-commit` 的简化用法。

## 限制输出长度
按时间限制,`--since`和`--until`选项
	git log --since=2.weeks
`--author`显示指定作者的提交，`--grep`选项搜索提交说明中的关键字。如果同事满足这两个条件搜索，必须用`--all-match`选项。

另外一个适用的是路径(path)
“选项	说明
-(n)	仅显示最近的 n 条提交”
--since, --after	仅显示指定时间之后的提交。
--until, --before	仅显示指定时间之前的提交。
--author	仅显示指定作者相关的提交。
--committer	仅显示指定提交者相关的提交。

ex:
	git log --pretty="%h-%s" --author="Hivan Du" --since="2015-1-10" --before="2015-1-11" --no-merges -- add/

## 图形化工具
	gitk

## 撤销操作
## 修改最后一次提交
	git commit --amend

