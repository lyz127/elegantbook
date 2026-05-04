# ElegantBook LaTeX3 重构版

本仓库用于将成熟版 `elegantbook.cls` 逐步迁移为基于 expl3/LaTeX3 组织的模块化文档类。当前主入口是 `elegantbook-l3.cls`，原版 `elegantbook.cls` 保留在根目录作为行为对照基准，中文示例文档 `elegantbook-cn.tex` 用于验证迁移后的接口和排版效果。

## 项目结构

- `elegantbook-l3.cls`：LaTeX3 重构版文档类入口，负责版本信息、类选项解析、加载 `book` 基类以及调度各功能模块。
- `elegant-*-module.code.tex`：按功能拆分的模块源码，当前包含选项、字体、语言、主题、封面、数学、核心排版、定理环境、参考文献、目录、代码和历史记录等模块。
- `elegantbook.cls`：原成熟版本，对照迁移用户接口、默认值和视觉行为时优先参考该文件。
- `elegantbook-cn.tex`：根目录中文测试文档，当前用于覆盖主题颜色、设备选项、定理类环境、普通练习环境和封面等迁移内容。
- `figure/`：示例文档所需图片资源。
- `ElegantBook/`：原项目发布结构的本地参考副本，已被 `.gitignore` 忽略，不作为当前重构版的提交目标。
- `plan.md`：迁移计划和模块归属草案，用于记录剩余工作。

## 构建与测试

在仓库根目录运行：

```powershell
latexmk -pdfxe elegantbook-cn.tex
```

或者

```powershell
latexmk -pdflua elegantbook-cn.tex
```

该命令会使用 XeLaTeX/LuaLaTeX 构建中文示例文档，生成 `elegantbook-cn.pdf`。修改模块后，建议至少运行一次该命令，确认没有编译错误、未定义控制序列或明显的接口回归。

清理常见 LaTeX 临时文件可运行：

```powershell
latexmk -c
```

## 开发说明

迁移时优先保持原版用户接口和默认行为，再逐步替换内部实现。新增逻辑应放入对应模块文件，避免把功能集中堆入 `elegantbook-l3.cls`。内部实现优先使用 expl3 命名和数据结构；用户可见命令与环境继续保持 LaTeX2e 风格，例如 `\elegantnewtheorem`、`example`、`remark` 等。

涉及行为差异时，请先查阅根目录 `elegantbook.cls` 和 `ElegantBook/` 参考副本，再更新模块实现与 `elegantbook-cn.tex` 测试样例。
