KaTeX-iOS
=========

A UIView that renders TeX expressions with KaTeX.

**To use:**

1. Copy UIKatexView.m and .h into your project.
2. Copy "katex" folder into your project directory (or wherever you want the library). Then drag the folder into XCode, making sure to set "Copy Folder References for Any Added Folders" and uncheck "Copy items into..." (f you've copied the folder)
3. See example project's ViewController.m for usage examples.


**Usage:**

Initialize using [UIKatexView katexView:tex center:cgpoint]. TeX expressions can be either:
- Pure expression (no $ signs!)
- Mixture of expression and text (HTML). Wrap a math expression in $ signs.
* You can also set a custom delimiter in place of the $ sign, using katexView:center:delimiter:.


**Example text (NSStrings):**

- I heard that $c = \\\\sqrt{a^2 - b^2}$ but I don't believe it.
- What is $n$ if $n \\\\cdot 4$ gives $8$?
- Remember that $\\\\displaystyle \\\\sum_{i=0}^n{i} = \\\\frac{(n)(n+1)}{2}$. Plugging in...
- \\\\displaystyle f(x) = \\\\int_{-\\\\infty}^\\\\infty \\\\hat f(\\\\xi)\\\\,e^{2 \\\\pi i \\\\xi x} \\\\,d\\\\xi

Remember that '\' character has to be escaped when used in an NSString.


**Credits:**

KaTeX (http://khan.github.io/KaTeX/)

UIKatexView by Ian Arawjo.