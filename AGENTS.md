# Repository Guidelines

## 项目结构与模块组织

本仓库当前目标是基于成熟项目 `elegantbook.cls` 进行 LaTeX3 语法重构与小幅行为微调。根目录是主工作区，`elegantbook-l3.cls` 是 LaTeX3 重构入口，按 `font`、`language`、`theme`、`cover`、`core`、`theorem` 的顺序加载 `elegant-*-module.code.tex` 模块。根目录的 `elegantbook.cls` 是成熟版本对照文件，`elegantbook-cn.tex` 与 `elegantbook-cn.pdf` 用于中文示例验证。

当前结构要点：

- `elegantbook-l3.cls`：重构版文档类入口，负责选项解析、加载 `book` 类和模块调度。
- `elegant-*-module.code.tex`：按功能拆分的 LaTeX3 模块源码，例如字体、语言、主题、封面、核心设置和定理环境。
- `elegantbook.cls`：原成熟实现的对照基准；迁移时优先核对其用户接口和默认行为。
- `elegantbook-cn.tex`：根目录测试文档，用于验证当前重构版。
- `figure/`：根目录示例所需封面、logo 等图片资源。
- `ElegantBook/`：原项目发布结构的本地参考副本，含 `build.lua`、中英文示例、`reference.bib`、`figure/`、`image/`，且已被根目录 `.gitignore` 忽略。
- `.gitignore`：忽略 `font/`、`ElegantBook/` 和常见 LaTeX 辅助文件。

## 构建、测试与开发命令

按修改范围选择运行目录。调试顶层重构版本时优先在仓库根目录运行；验证原发布结构时进入 `ElegantBook/`。

- `latexmk -pdfxe elegantbook-cn.tex`：在仓库根目录构建中文示例，验证 `elegantbook-l3.cls` 和模块迁移效果。
- `latexmk -pdfxe elegantbook-cn.tex`：在 `ElegantBook/` 中构建原中文示例，用于和成熟版本对照；该目录默认不纳入主仓库提交。
- `latexmk -pdf elegantbook-en.tex`：在 `ElegantBook/` 中构建原英文示例。
- `l3build doc`：在 `ElegantBook/` 中按 `build.lua` 构建文档。
- `l3build ctan`：在 `ElegantBook/` 中生成 CTAN 风格发布包；仅在准备发布时使用。
- `latexmk -c`：清理常见 LaTeX 构建临时文件。

## 代码风格与命名约定

新增或迁移代码优先使用 expl3/LaTeX3 接口，命名应体现模块职责，并和现有 `elegant-<area>-module.code.tex` 格式保持一致，例如 `elegant-theme-module.code.tex`。迁移时尽量保持原 `elegantbook.cls` 的用户接口、选项名和默认行为不变，只在有明确需求时做微调。Lua 文件（`build.lua`）使用两个空格缩进，并保持已有赋值块对齐。避免对原成熟版本、生成的 `.cls` 文件和示例文档做无关格式化。

LaTeX3 宏命名应遵循 expl3 语义化签名和作用域约定。对外或跨模块复用的内部 API 使用 `\elegant_<verb>_<object>:<arg-spec>`，例如 `\elegant_declare_theme:nn`、`\elegant_use_color:n`、`\elegant_add_to_hook:nnnn`；仅模块内部使用的辅助宏使用 `\__elegant_<module>_<verb>_<object>:<arg-spec>`，例如 `\__elegant_parse_unknown_option:n`。函数名中的 `<arg-spec>` 必须真实反映参数类型与展开行为，例如 `:n`、`:N`、`:nn`、`:nx`、`:TF`，需要变体时使用 `\cs_generate_variant:Nn` 生成，避免手写语义不清的重复宏。

变量命名使用 expl3 类型后缀并标出作用域。全局状态使用 `\g__elegant_<module-or-purpose>_<type>`，局部状态使用 `\l__elegant_<module-or-purpose>_<type>`，常量使用 `\c__elegant_<module-or-purpose>_<type>`；类型后缀应匹配数据结构，例如 `_tl`、`_bool`、`_int`、`_dim`、`_clist`、`_seq`、`_prop`。临时变量也应保持双下划线内部命名，例如优先写 `\l__elegant_tmp_cnt_name_tl`，不要新增 `\l_elegant_...` 这类缺少内部命名标记的变量。通过 `:c`/`:cn` 动态构造的内部变量名也应尽量保持同一规范，即使用 `g__elegant_...` 或 `l__elegant_...` 前缀；若为兼容既有代码暂用旧式 `g_elegant_...` 名称，应局部限定并避免继续扩散。

用户可见命令和环境继续使用 LaTeX2e 风格接口，由 `\NewDocumentCommand`、`\RenewDocumentCommand`、`\DeclareDocumentCommand`、`\NewDocumentEnvironment` 或 `\DeclareDocumentEnvironment` 定义，例如 `\elegantnewtheorem`、`introduction`。这类命令不带 expl3 参数签名，命名优先兼容原 `elegantbook.cls` 和示例文档；实现细节则委托给带签名的 `\elegant_...:` 或 `\__elegant_...:` 函数。消息名、键路径和 hook 名称使用稳定的文本命名空间：消息归入 `elegant`，类选项归入 `elegant / classoption`，模块 hook 采用 `elegant-module / <module> / <name> / <before|after>`。

## 测试指南

本仓库没有独立自动化测试套件。请把示例文档构建和 PDF 对照作为主要回归检查。修改模块后，至少构建顶层 `elegantbook-cn.tex`，检查编译错误、警告、缺失引用和页面视觉变化。涉及用户接口、字体、主题、定理环境或封面逻辑时，应和 `ElegantBook/` 中原示例输出对照，确认改动属于预期迁移或微调。

## 提交与 Pull Request 指南

近期提交历史使用简短主题，常见形式包括祈使句或日期前缀，例如 `add tcolorbox`、`0919 add more font options`、`0914 add hook to module`。提交标题应简洁，并聚焦单一迁移或微调。Pull Request 应说明迁移的模块、是否改变用户可见行为、已运行的构建命令，以及和原 `elegantbook.cls` 的差异；涉及视觉变化时，请提供前后 PDF 截图或页码说明。

## 重构与迁移注意事项

迁移时先保留行为，再替换实现。优先把相关逻辑放入对应模块文件，避免把新代码集中堆入 `elegantbook-l3.cls`。对外选项、环境名、命令名和文档示例应尽量兼容成熟版本。需要参考原项目时读取 `ElegantBook/`，但不要把该目录中的临时构建结果带回主仓库。修改包元数据或准备发布时，再同步更新 `ElegantBook/build.lua` 中的 `version`、`maintainer`、`summary` 和 CTAN 上传信息。不要提交本地 `font/` 内容，也不要提交 `.gitignore` 已忽略的 LaTeX 辅助文件。
