# Repository Guidelines

## 项目结构与模块组织

本仓库包含 ElegantBook LaTeX 文档类及其发布文件。顶层 `elegant-*-module.code.tex` 文件保存模块化源码，`elegantbook-l3.cls` 与 `elegantbook.cls` 是生成或打包后的文档类文件。`elegantbook-cn.tex` 是主要中文说明示例，`elegantbook-cn.pdf` 是对应构建产物。`figure/` 存放封面和标志图片。嵌套的 `ElegantBook/` 目录是 CTAN 风格发布结构，包含 `build.lua`、`README.md`、`License`、`reference.bib`、中英文说明文档，以及 `figure/` 和 `image/` 资源目录。

## 构建、测试与开发命令

除非特别说明，以下命令从 `ElegantBook/` 目录运行。

- `l3build doc`：根据 `build.lua` 构建说明文档；中文文档会使用 `latexmk -pdfxe`。
- `l3build ctan`：按 `build.lua` 中的文件列表和复制钩子生成 CTAN 发布压缩包。
- `latexmk -pdfxe elegantbook-cn.tex`：手动构建中文说明，适合调试 XeLaTeX 相关问题。
- `latexmk -pdf elegantbook-en.tex`：手动构建英文说明。
- `latexmk -c`：清理常见 LaTeX 构建临时文件。

## 代码风格与命名约定

沿用现有 LaTeX2e/expl3 写法和文档类文件中的局部风格。模块文件名使用 `elegant-<area>-module.code.tex` 格式，例如 `elegant-theme-module.code.tex`。Lua 文件（`build.lua`）优先使用两个空格缩进，并保持已有赋值块对齐。避免对生成的 `.cls` 文件和示例文档做无关格式化。

## 测试指南

本仓库没有独立自动化测试套件。请把说明文档能否成功构建作为回归检查。提交文档类变更前，应构建 `elegantbook-cn.tex` 和 `elegantbook-en.tex`，检查警告、缺失引用和 PDF 视觉变化。修改资源文件时，确认引用文件存在于 CTAN 发布结构中的 `figure/` 或 `image/` 目录。

## 提交与 Pull Request 指南

近期提交历史使用简短主题，常见形式包括祈使句或日期前缀，例如 `add tcolorbox`、`0919 add more font options`、`0914 add hook to module`。提交标题应简洁，并聚焦单一变更。Pull Request 应说明对用户可见的 LaTeX 行为变化，列出已运行的构建命令，关联相关 issue；涉及视觉模板变化时，请提供前后 PDF 截图或页码说明。

## 打包注意事项

修改包元数据时，请同步更新 `ElegantBook/build.lua` 中的 `version`、`maintainer`、`summary` 和 CTAN 上传信息。不要提交本地 `font/` 内容，也不要提交 `.gitignore` 已忽略的 LaTeX 辅助文件。
