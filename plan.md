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

## 按模块迁移清单

- [ ] `elegantbook-l3.cls`

  - [X] 已迁移：类版本信息、模块加载机制、全局消息接口。
  - [X] 已迁移：基础选项解析、未知选项转发给 `book` 类、`tocdepth` 与 `secnumdepth` 设置。
  - [ ] 未迁移：完整原版选项声明与旧式 void option 兼容。
  - [ ] 未迁移：发布时类名、版本号、生成目标和 CTAN 打包策略。
- [ ] `elegant-option-module.code.tex`

  - [X] 已迁移：模块文件骨架、选项别名表和声明接口占位。
  - [ ] 未迁移：`color`、`result`、`device`、`math`、`marginpar`、`toc`、`scheme` 等原版选项。
  - [ ] 未迁移：`green`、`cyan`、`blue`、`gray`、`black`、`nocolor` 等旧颜色选项映射。
  - [ ] 未迁移：`answer/noanswer`、`normal/pad`、`onecol/twocol`、`chapter/section`、`biber/bibtex`、`hang/display` 等 void option 映射。
- [ ] `elegant-font-module.code.tex`

  - [X] 已迁移：字体声明框架、`founder`、`source-han`、`ctex-*`、`none` 字体入口。
  - [ ] 未迁移：XeTeX/LuaTeX 完整分支。
  - [ ] 未迁移：原版 `chinesefont=ctexfont/founder/nofont` 行为兼容。
  - [ ] 未迁移：`\cbfseries`、`\citshape`、`\cnormal`、`\cfs` 等辅助命令。
- [ ] `elegant-language-module.code.tex`

  - [X] 已迁移：语言声明框架、中文 `cn` 的部分名称表。
  - [X] 未迁移：`en`、`it`、`fr`、`nl`、`hu`、`de`、`es`、`mn`、`pt`、`jp`。
  - [ ] 未迁移：多语言下的 `babel`、`luatexja`、目录名、附录名、引用名和环境名完整映射。
  - [ ] 未迁移：`\figref`、`\tabref`、`\authorname`、`\historyname` 等语言化命令。
- [ ] `elegant-theme-module.code.tex`

  - [X] 已迁移：主题声明框架和 `Techno Blue`、`Fresh Green`、`Polar Blue`、`Rocky Gray`、`Neon Black`。
  - [ ] 未迁移：原版 `color=green/cyan/blue/gray/black/none` 兼容。
  - [ ] 未迁移：`structurecolor`、`main`、`second`、`third`、`winered`、`bule` 等原版颜色语义。
  - [ ] 未迁移：表格颜色、链接颜色和定理颜色的完整对应关系。
- [ ] `elegant-cover-module.code.tex`

  - [X] 已迁移：封面信息表、封面样式声明接口、`default`、`Skyrmion`、`mono` 样式。
  - [X] 已迁移：`\ElegantCoverInfo`、`\ElegantDeclareCoverStyle`、`\ElegantUseCoverInfo`。
  - [ ] 未迁移：原版 `\subtitle`、`\institute`、`\version`、`\extrainfo`、`\logo`、`\cover`、`\email` 接口。
  - [ ] 未迁移：原版 `\maketitle` 的版式、作者信息、logo、封面图和 extra info 行为。
- [ ] `elegant-math-module.code.tex`

  - [X] 已迁移：模块骨架和 `cm/newtx/mtpro2` 数学选项占位。
  - [ ] 未迁移：`math=cm/newtx/mtpro2` 的实际包加载。
  - [ ] 未迁移：`newtxmath`、`mtpro2`、`esint`、`bm`、数学符号包和相关字体默认值。
  - [ ] 未迁移：不同引擎下数学字体与文本字体协调逻辑。
- [ ] `elegant-core-module.code.tex`

  - [X] 已迁移：基础 geometry、`graphicspath`、章节标题、页眉页脚、hyperref、英文字体、列表样式。
  - [X] 已迁移：`\circled`、列表项目符号和 `introduction` 环境。
  - [ ] 未迁移：`setspace`、`csquotes`、`indentfirst`、`comment`、`caption`、`booktabs`、`multirow`、`fancyvrb`、`makecell`、`hologo`、`appendix`、`apptools` 等原版基础依赖。
  - [ ] 未迁移：`\mailto`、`\question`、`\bioinfo`、`\dollar` 等常用宏。
- [ ] `elegant-theorem-module.code.tex`

  - [X] 已迁移：`fancy/simple` 模式框架。
  - [X] 已迁移：`theorem`、`definition`、`postulate`、`axiom`、`corollary`、`lemma`、`proposition`、`remark`。
  - [ ] 未迁移：`example`、`exercise`、`problem`、`note`、`proof`、`solution`、`assumption`、`conclusion`、`property`、`custom`、`problemset`。
  - [ ] 未迁移：原版 `\elegantnewtheorem` 的完整参数签名、样式选择、前缀、共享计数、警告和错误处理。
- [ ] `elegant-bibliography-module.code.tex`

  - [X] 已迁移：模块骨架和 `citestyle`、`bibstyle`、`bibend` 变量占位。
  - [ ] 未迁移：`biber/bibtex` 后端选择。
  - [ ] 未迁移：参考文献包加载、样式选择和 bibliography 名称语言化。
  - [ ] 未迁移：原版示例文档的参考文献编译兼容。
- [ ] `elegant-toc-module.code.tex`

  - [X] 已迁移：模块骨架、`toc` 与 `title style` 变量占位。
  - [ ] 未迁移：`toc=onecol/twocol`。
  - [ ] 未迁移：`\tableofcontents` 重定义、`tocloft`、`\numberline` 定制。
  - [ ] 未迁移：附录目录显示、`\cleardoublepage` 调整和章节名前后缀处理。
- [ ] `elegant-code-module.code.tex`

  - [X] 已迁移：模块骨架和 setup hook。
  - [ ] 未迁移：`listings` 加载与默认样式。
  - [ ] 未迁移：LaTeX 代码高亮关键字、`lightgrey`、`frenchplum` 等颜色。
  - [ ] 未迁移：原版等宽字体切换和代码展示默认行为。
- [ ] `elegant-history-module.code.tex`

  - [X] 已迁移：模块骨架、版本历史序列和 setup hook。
  - [ ] 未迁移：`\dateinfoline`、`\datechange`、`\listofchanges`。
  - [ ] 未迁移：`change` 环境。
  - [ ] 未迁移：更新历史标题的多语言名称和目录行为。

## `elegantbook-l3.cls` 中的模块组织顺序

入口类文件应只承担全局调度职责：声明类信息、定义消息接口、解析类选项、加载 `book` 基类，并按依赖关系载入各模块。模块内部尽量通过 hook 暴露扩展点，避免彼此直接硬编码依赖。

建议加载顺序如下：

1. `font`：先准备字体声明框架和中文字体策略，供语言、标题、定理等模块使用。
2. `option`：集中处理旧选项别名和兼容映射；当前仍是骨架，后续可逐步把入口类中的兼容逻辑迁入此处。
3. `language`：定义名称表、章节名、环境名和语言相关文本，供 `core`、`cover`、`theorem`、`toc` 使用。
4. `theme`：定义颜色语义和主题色，供封面、标题、页眉页脚、定理、代码样式使用。
5. `cover`：依赖语言名称和主题颜色，负责封面信息、封面样式和 `\maketitle`。
6. `math`：处理数学字体和符号包，需早于大量内容环境加载。
7. `core`：加载基础排版包，设置页面尺寸、标题格式、页眉页脚、链接、列表和通用宏。
8. `theorem`：依赖 `language`、`theme`、`core` 和可能的数学包，定义定理、练习、证明等环境。
9. `bibliography`：处理参考文献后端、引用样式和 bibliography 名称。
10. `toc`：处理目录、附录、章节编号和目录显示；应在语言、标题和核心排版之后加载。
11. `code`：处理 `listings` 和代码块样式，依赖主题颜色和核心字体设置。
12. `history`：处理版本更新历史，依赖语言名称和目录机制，适合最后加载。

当前 `elegantbook-l3.cls` 中的实际加载顺序应保持为：

```tex
\elegant_load_module:n { font }
\elegant_load_module:n { option }
\elegant_load_module:n { language }
\elegant_load_module:n { theme }
\elegant_load_module:n { cover }
\elegant_load_module:n { math }
\elegant_load_module:n { core }
\elegant_load_module:n { theorem }
\elegant_load_module:n { bibliography }
\elegant_load_module:n { toc }
\elegant_load_module:n { code }
\elegant_load_module:n { history }
```

后续迁移时，如果某个模块需要新增跨模块依赖，优先通过 `elegant-module / <module> / <name> / before` 与 `after` hook 协调；只有全局选项解析、类加载和模块顺序调整才应修改 `elegantbook-l3.cls`。
