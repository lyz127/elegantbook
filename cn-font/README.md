# 中文字体方案测试

这些文件用于单独测试 `elegantbook-l3` 的中文 `ctex-*` 字体方案。

运行命令示例：

```sh
latexmk -g -pdfxe -interaction=nonstopmode -halt-on-error elegantbook-cn-font-ctex-fandol.tex
```

## 当前环境测试结果

测试环境：Windows + TeX Live 2026 + XeLaTeX。

| 字体方案 | 结果 | 说明 |
| --- | --- | --- |
| `ctex-adobe` | 通过 | 已生成 PDF。 |
| `ctex-fandol` | 通过 | 已生成 PDF。 |
| `ctex-founder` | 通过 | 已生成 PDF。 |
| `ctex-windows` | 通过 | 已生成 PDF。 |
| `ctex-lxgw` | 通过 | 已生成 PDF。 |
| `ctex-mac` | 未通过 | 当前 Windows 环境缺少 macOS 字体 `STHeiti`。 |
| `ctex-macnew` | 未通过 | 当前 Windows 环境缺少 macOS 字体 `Kaiti SC`。 |
| `ctex-macold` | 未通过 | 当前 Windows 环境缺少 macOS 字体 `STHeiti`。 |
| `ctex-ubuntu` | 未通过 | XeLaTeX 阶段通过，`xdvipdfmx` 在当前本机字体映射下报 `Invalid TTC index number`。 |

`ctex-mac`、`ctex-macnew`、`ctex-macold` 和 `ctex-ubuntu` 是平台字体方案；上述失败说明当前机器缺少或无法正确解析对应平台字体，不表示 `font = ctex-*` 选项映射本身失效。
