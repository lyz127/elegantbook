# 数学字体方案测试

这些文件用于单独测试 `elegantbook-l3` 的 `math` 数学字体方案。

运行命令示例：

```sh
latexmk -g -pdfxe -interaction=nonstopmode -halt-on-error elegantbook-math-newtx.tex
```

## 当前环境测试结果

测试环境：Windows + TeX Live 2026 + XeLaTeX。

| 数学字体方案 | 结果 | 说明 |
| --- | --- | --- |
| `math=cm` | 通过 | 已生成 PDF。 |
| `math=newtx` | 通过 | 已生成 PDF。 |
| `math=mtpro2` | 通过 | 已生成 PDF；当前环境已安装 `mtpro2`。 |
| `math=stixtwo` | 通过 | 已生成 PDF。 |
| `math=xits` | 通过 | 已生成 PDF。 |
| `math=tg` | 通过 | 已生成 PDF。 |

