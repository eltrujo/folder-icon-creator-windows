# -*- coding: utf-8 -*-
"""
Created on Thu Jul 20 21:31:20 2017

@author: github.com/eltrujo
"""
def CreateICO(folderPath,pngName):
    from wand.image import Image
    with Image(filename=folderPath+pngName) as img:
        img.format = 'ico'
        img.resize(256,256)
        img.save(filename=folderPath+'favicon.ico')