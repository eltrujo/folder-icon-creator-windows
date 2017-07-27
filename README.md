# folder-icon-creator-windows

Create an ICO file out of a JPG image and programmatically set it as folder icon.

Softwares:
·MATLAB
·Python ('wand' module)

1. Matlab converts the JPG picture into a square PNG filling the emptiness with transparent pixels and, therefore, respecting the height-width ratio (as long as height > width).
2. Matlab calls Python (CreateICO function from CreateICO.py) to convert the PNG picture into a 256x256 ICO file: favicon.ico. Python's module 'wand' is required, otherwise it will give an error when importing it. Try typing 'pip install wand' on the command prompt, otherwise follow this guide: http://docs.wand-py.org/en/0.4.1/guide/install.html
3. Back to Matlab, it sets the file favicon.ico as folder icon, writing the file 'desktop.ini'.

Note: sometimes the explorer needs to be refreshed to see the result.
