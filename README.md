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
- 　



\`

