## 期末作業 用verilog做nand2tetris 1~5章  

11/7 第一章nand,not,and,or,xor,or8way 完成  
11/25 第一章not16,and16,or16 完成  
11/26 第一章 完成  
11/26 第二章 完成  
11/27 第三章 完成
12/6 全部完成


### 遇到的問題:  
在寫Memory,CPU,Computer時遇到一些我無法解決的bug  
一開始以為是我之前nand2tetris的時候寫錯,所以出現錯誤,但我研究過後發現我寫的是對的  
於是開始思考是不是我output名字取太亂,所以我照著老師的程式改output名字  
但依舊出現這種錯誤訊息,於是開始上網查資料,因為是test的程式出現問題,所以開始學test程式裡每一句的句子  
終於,我搞定它了,是我rom跟CPU的模組名稱沒有設好,所以錯誤
```
錯誤訊息:
computer_test.v:12: error: Unable to bind wire/reg/memory `c.rom.m' in `main'   
computer_test.v:15: error: Scope index expression is not constant: i
computer_test.v:15: error: Unable to bind wire/reg/memory `c.rom.m[i]' in `main'
computer_test.v:17: error: Unable to bind wire/reg/memory `c.cpu.Dout' in `main'
```
### 心得:
Verilog裡的一些語法和邏輯我覺得與我相對熟悉的C和Python相比差蠻多的  
對我而言是蠻大的挑戰,但也對這個語言開始產生興趣,之後會想要繼續深入鑽研  



```
所有的測試程式來自陳鍾誠老師的教學資料 網址:https://gitlab.com/cccnqu111/co/-/tree/master/verilog/02-nand2tetris  
其他的程式都參考我自己寫的nand2tetris
```
