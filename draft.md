# ElegantBook LaTeX3 完整迁移草案

## 建议模块文件划分

若目标是完整迁移原版 `elegantbook.cls`，建议最终划分为 **12 个模块文件**，加上入口类文件 `elegantbook-l3.cls`。当前已有 6 个模块，可继续保留并扩展；另需新增 6 个模块。

入口文件：

- `elegantbook-l3.cls`：只负责版本信息、选项解析、基础类加载、模块调度和全局消息接口。

已有模块：

- `elegant-font-module.code.tex`
- `elegant-language-module.code.tex`
- `elegant-theme-module.code.tex`
- `elegant-cover-module.code.tex`
- `elegant-core-module.code.tex`
- `elegant-theorem-module.code.tex`

建议新增模块：

- `elegant-option-module.code.tex`
- `elegant-math-module.code.tex`
- `elegant-bibliography-module.code.tex`
- `elegant-toc-module.code.tex`
- `elegant-code-module.code.tex`
- `elegant-history-module.code.tex`

## 未完成内容与模块归属

### 1. 选项兼容层

归属：`elegant-option-module.code.tex`

原版选项尚未完整兼容，包括 `color`、`result`、`device`、`math`、`marginpar`、`toc`、`scheme`、`chinesefont`、`citestyle`、`bibstyle`、`bibend`、`titlestyle` 等。旧式 void options 也需要映射，例如 `green`、`cyan`、`blue`、`gray`、`black`、`nocolor`、`ctexfont`、`founder`、`nofont`、`answer`、`noanswer`、`normal`、`pad`、`onecol`、`twocol`、`chapter`、`section`、`biber`、`bibtex`、`hang`、`display`。

### 2. 多语言支持

归属：`elegant-language-module.code.tex`

当前主要实现中文 `cn`。原版还包含 `en`、`it`、`fr`、`nl`、`hu`、`de`、`es`、`mn`、`pt`、`jp` 等语言的标题、环境名、引用名、目录名、附录名和部分 `babel`/`luatexja` 加载逻辑。应逐步迁移到统一的名称表接口。

### 3. 主题与颜色兼容

归属：`elegant-theme-module.code.tex`

当前使用新主题名，如 `Techno Blue`、`Fresh Green`。原版使用 `color=green/cyan/blue/gray/black/none`。需要保留新主题系统，同时提供旧选项兼容映射，并补齐 `structurecolor`、`main`、`second`、`third`、`winered` 等原版颜色语义。

### 4. 字体、引擎与数学配置

归属：`elegant-font-module.code.tex`、`elegant-math-module.code.tex`

字体模块需补齐 pdfTeX/XeTeX/LuaTeX 分支、`ctexfont`、`nofont` 等旧接口，并恢复 `\cbfseries`、`\citshape`、`\cnormal`、`\cfs` 等原版辅助命令。数学模块负责 `math=cm/newtx/mtpro2`、`newtxmath`、`mtpro2`、`esint`、`bm`、数学符号包和相关默认字体切换。

### 5. 封面与用户元信息接口

归属：`elegant-cover-module.code.tex`

当前封面改为 `\ElegantCoverInfo{...}` 接口，和原版 `\subtitle`、`\institute`、`\version`、`\extrainfo`、`\logo`、`\cover`、`\email` 等接口不兼容。需要提供兼容命令，并决定旧接口是直接写入 cover info，还是保留 `\@subtitle` 等内部变量后再桥接。

### 6. 核心排版与常用宏

归属：`elegant-core-module.code.tex`

需补齐原版基础包和排版行为，包括 `setspace`、`csquotes`、`indentfirst`、`comment`、`caption`、`graphicx`、`amsmath`、`mathrsfs`、`amsfonts`、`amssymb`、`booktabs`、`multirow`、`fancyvrb`、`makecell`、`hologo`、`appendix`、`apptools` 等。还需恢复 `\mailto`、`\question`、`\figref`、`\tabref`、`\bioinfo`、`\dollar` 等常用用户命令。

### 7. 定理与练习环境

归属：`elegant-theorem-module.code.tex`

当前只迁移了基础定理类环境。仍需补齐 `example`、`exercise`、`problem`、`note`、`proof`、`solution`、`assumption`、`conclusion`、`property`、`custom`、`problemset` 等环境。`\elegantnewtheorem` 也需恢复原版签名和行为，包括标题名、样式、前缀、共享计数、警告和错误处理。

### 8. 参考文献

归属：`elegant-bibliography-module.code.tex`

原版包含 `citestyle`、`bibstyle`、`bibend=biber/bibtex` 等选项。需要确定迁移目标是继续兼容原版后端选择，还是统一到 `biblatex`。该模块应集中处理参考文献包加载、样式选择、语言化 bibliography 名称和示例文档兼容。

### 9. 目录、附录与章节编号

归属：`elegant-toc-module.code.tex`

需迁移 `toc=onecol/twocol`、`\tableofcontents` 重定义、`tocloft`、`cleardoublepage` 调整、附录目录显示、`\numberline` 定制，以及不同语言下章节名前后缀处理。`titlestyle=hang/display` 也可放在此模块，或由 `core` 提供底层标题格式后在此模块处理兼容选项。

### 10. 代码列表样式

归属：`elegant-code-module.code.tex`

原版使用 `listings` 并定义 LaTeX 代码高亮、颜色、关键字和等宽字体切换。该模块应恢复 `lstdefinestyle`、`\lstset`、`lightgrey`、`frenchplum` 等颜色和代码展示默认样式。

### 11. 版本更新历史

归属：`elegant-history-module.code.tex`

原版包含 `\dateinfoline`、`\datechange`、`\listofchanges` 和 `change` 环境，用于生成版本更新历史。该功能独立性强，适合单独成模块，避免污染 core。

### 12. 构建与发布兼容

归属：`elegantbook-l3.cls`、`ElegantBook/build.lua`

完整迁移后，需要决定 `elegantbook-l3.cls` 是否作为新类名发布，还是生成兼容名 `elegantbook.cls`。准备发布时再同步 `ElegantBook/build.lua` 中的 `version`、`typesetfiles`、`sourcefiles`、`docfiles` 和 CTAN 元数据。

## 建议迁移顺序

1. 新建 `elegant-option-module.code.tex`，先补齐原版选项到新内部变量的映射。
2. 扩展 `language`、`theme`、`font`，确保旧文档的语言、颜色、字体选项能正常编译。
3. 补 `cover` 与 `core` 的原版用户命令，优先保证旧示例文档不改源码即可运行。
4. 完整迁移 `theorem` 中的练习、证明、解答和 problemset 环境。
5. 新增 `math`、`bibliography`、`toc` 三个模块，处理数学字体、参考文献、目录附录。
6. 最后新增 `code` 和 `history` 模块，迁移代码列表和版本历史等文档辅助功能。
