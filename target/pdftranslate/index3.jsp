<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PDF Google 翻译</title>
    <link rel="stylesheet" type="text/css" href="/pdftranslate/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="/pdftranslate//resources/css/ui.css">
    <link rel="icon" type="image/png" href="/pdftranslate//resources/img/pdfcopy-icon.png" />
    <style>
    </style>
</head>

<body>

    <div id="mid">

        <div id="left-container">
            <div id="input-container">

                <div class="toolbar">
                    <div class="tool">
                        <input class="tab-input" id="tabCh" type="radio" name="tabs" >
                        <label class="tab-label" for="tabCh" onclick="setMode(modeCh); checkChinese();">中文模式</label>

                        <input class="tab-input" id="tabEn" type="radio" name="tabs"checked>
                        <label class="tab-label" for="tabEn" onclick="setMode(modeEn); checkEnglish();">英文模式</label>
                        <label class="tab-label" ></label>
                        <label class="tab-label" ></label>
                        <label class="tab-label" ></label>
                        <label class="tab-label" onclick="gotoUrl();">翻译</label>
                        <label class="tab-label" onclick="gettkk();">初始化</label>
                    </div>
                </div>
                <div class="tx-area-wrap">
                    <textarea class="tx-area" id="text-input" placeholder=""></textarea>
                    <div class="btn-clear-wrap">
                        <div class="btn btn-clear" onclick="clearText()"></div>
                    </div>
                </div>
            </div>

        </div>

        <div id="right-container">
            <div id="output-container">

                <div class="toolbar">
                    <label class="cbx-container tool">自动复制
                        <input id="autoCopy" type="checkbox" onclick="setAutoCopy()">
                        <span class="checkmark"></span>
                    </label>
                </div>

                <div class="tx-area-wrap">
                    <textarea class="tx-area" id="text-output" placeholder=""></textarea>
                    <div class="btn-copy-wrap">
                        <div style="height:22px">
                            <div class="btn btn-copy" onclick="copyOutput()"></div>
                        </div>
                        <div class="copy-text">
                            <span>已复制</span>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
	<div id="bottom-container">
		<div class="tx-area-wrap">
    		<textarea class="tx-area" id="text-translate"></textarea>
            <div class="btn-clear-wrap">
                <div class="btn btn-clear" onclick="clearText()"></div>
            </div>
    	</div>
	</div>

    <script type="text/javascript">

        var textInput = null;
        var textOutput = null;
        var textTranslate = null;
        var modeCh = 'ch';
        var modeEn = 'en';

        window.onload = init;

        init();

        function init() {
            textInput = document.getElementById('text-input');
            textOutput = document.getElementById('text-output');
            textTranslate = document.getElementById('text-translate');

            switch (getMode()) {
                case modeCh:
                    document.getElementById('tabCh').checked = true;
                    checkChinese();
                    break;
                case modeEn:
                    document.getElementById('tabEn').checked = true;
                    checkEnglish();
                    break;
            }
            document.getElementById('autoCopy').checked = isAutoCopy();

            textInput.oninput = exec;
        }

        function checkChinese() {
            textInput.placeholder = '- 来吧，往这粘';
            textOutput.placeholder = '- 中文模式 将会 去除换行符、去除空格、规范全角半角';
            exec();
        }
        function checkEnglish() {
            textInput.placeholder = '- 来吧，往这粘';
            textOutput.placeholder = '- 英文模式 将会 去除换行符、规范空格、规范全角半角';
            exec();
        }

        function exec() {
            textInput.focus();
            if (getMode() === modeCh) {
                textOutput.value = execCh(textInput.value);
            } else {
                textOutput.value = execEn(textInput.value);
            }
            if (isAutoCopy()) {
                copyOutput();
            }
        }

        var regexWhiteSpace = /\s/g;
        var regexMultiSpace = /\s+/g;

        function execCh(str) {
            str = dbc2sbc(str);
            str = str.replace(regexWhiteSpace, '');
            return str;
        }

        function execEn(str) {
            str = dbc2sbc(str);
            str = str.replace(regexMultiSpace, ' ');
            return str;
        }

        function dbc2sbc(str) {
            let result = '';
            for (let i = 0; i < str.length; i++) {
                let charCode = str.charCodeAt(i);
                if ((charCode >= 65296 && charCode <= 65305) || //0~9
                    (charCode >= 65313 && charCode <= 65338) || //A~Z
                    (charCode >= 65345 && charCode <= 65370)) { //a~z
                    result += String.fromCharCode(charCode - 65248)
                } else if (charCode == 12288) { //space
                    result += String.fromCharCode(32);
                } else {
                    result += str[i];
                }
            }
            return result;
        }

        function clearText() {
            textInput.value = '';
            textOutput.value = '';
            textTranslate.value = '';
            textInput.focus();
        }

        function copyOutput() {
            if (textOutput.value === '') {
                return;
            }

            textOutput.select();
            document.execCommand('copy');
            textInput.focus();

            let copyText = document.getElementsByClassName('copy-text')[0];
            copyText.style.transition = '0s';
            copyText.style.opacity = 1;
            setTimeout(() => { copyText.style.transition = '1s'; copyText.style.opacity = 0; }, 2000);
        }

        function getMode() {
            if (localStorage.mode) {
                return localStorage.mode;
            } else {
                return modeCh;
            }
        }

        function setMode(v) {
            localStorage.mode = v;
        }

        function isAutoCopy() {
            if (localStorage.autocopy) {
                return localStorage.autocopy === 'true';
            } else {
                return false;
            }
        }

        function setAutoCopy() {
            localStorage.autocopy = document.getElementById('autoCopy').checked;
        }

        //计算tk值 版本1
        function shiftLeftOrRightThenSumOrXor(num, opArray) {
            return opArray.reduce((acc, opString) => {
                var op1 = opString[1];  //  '+' | '-' ~ SUM | XOR
                var op2 = opString[0];  //  '+' | '^' ~ SLL | SRL
                var xd = opString[2];   //  [0-9a-f]

                var shiftAmount = hexCharAsNumber(xd);
                var mask = (op1 == '+') ? acc >>> shiftAmount : acc << shiftAmount;
                return (op2 == '+') ? (acc + mask & 0xffffffff) : (acc ^ mask);
            }, num);
        }

        function hexCharAsNumber(xd) {
            return (xd >= 'a') ? xd.charCodeAt(0) - 87 : Number(xd);
        }

        function transformQuery(query) {
            for (var e = [], f = 0, g = 0; g < query.length; g++) {
              var l = query.charCodeAt(g);
              if (l < 128) {
                e[f++] = l;                 //  0{l[6-0]}
              } else if (l < 2048) {
                e[f++] = l >> 6 | 0xC0;     //  110{l[10-6]}
                e[f++] = l & 0x3F | 0x80;   //  10{l[5-0]}
              } else if (0xD800 == (l & 0xFC00) && g + 1 < query.length && 0xDC00 == (query.charCodeAt(g + 1) & 0xFC00)) {
                //  that's pretty rare... (avoid ovf?)
                l = (1 << 16) + ((l & 0x03FF) << 10) + (query.charCodeAt(++g) & 0x03FF);
                e[f++] = l >> 18 | 0xF0;        //  111100{l[9-8*]}
                e[f++] = l >> 12 & 0x3F | 0x80; //  10{l[7*-2]}
                e[f++] = l & 0x3F | 0x80;       //  10{(l+1)[5-0]}
              } else {
                e[f++] = l >> 12 | 0xE0;        //  1110{l[15-12]}
                e[f++] = l >> 6 & 0x3F | 0x80;  //  10{l[11-6]}
                e[f++] = l & 0x3F | 0x80;       //  10{l[5-0]}
              }
            }
            return e;
        }

        function normalizeHash(encondindRound2) {
            if (encondindRound2 < 0) {
                encondindRound2 = (encondindRound2 & 0x7fffffff) + 0x80000000;
            }
            return encondindRound2 % 1E6;
        }

        function calcHash(query, windowTkk) {
            //  STEP 1: spread the the query char codes on a byte-array, 1-3 bytes per char
            var bytesArray = transformQuery(query);

            //  STEP 2: starting with TKK index, add the array from last step one-by-one, and do 2 rounds of shift+add/xor
            var d = windowTkk.split('.');
            var tkkIndex = Number(d[0]) || 0;
            var tkkKey = Number(d[1]) || 0;

            var encondingRound1 = bytesArray.reduce((acc, current) => {
                acc += current;
                return shiftLeftOrRightThenSumOrXor(acc, ['+-a', '^+6'])
            }, tkkIndex);

            //  STEP 3: apply 3 rounds of shift+add/xor and XOR with they TKK key
            var encondingRound2 = shiftLeftOrRightThenSumOrXor(encondingRound1, ['+-3', '^+b', '+-f']) ^ tkkKey;

            //  STEP 4: Normalize to 2s complement & format
            var normalizedResult = normalizeHash(encondingRound2);

            return normalizedResult.toString() + "." + (normalizedResult ^ tkkIndex)
        }
        
        //计算tk值，版本2
        function vq(a,uq='422388.3876711001') {
		    if (null !== uq)
		        var b = uq;
		    else {
		        b = sq('T');
		        var c = sq('K');
		        b = [b(), c()];
		        b = (uq = window[b.join(c())] || "") || ""
		    }
		    var d = sq('t');
		    c = sq('k');
		    d = [d(), c()];
		    c = "&" + d.join("") + "=";
		    d = b.split(".");
		    b = Number(d[0]) || 0;
		    for (var e = [], f = 0, g = 0; g < a.length; g++) {
		        var l = a.charCodeAt(g);
		        128 > l ? e[f++] = l : (2048 > l ? e[f++] = l >> 6 | 192 : (55296 == (l & 64512) && g + 1 < a.length && 56320 == (a.charCodeAt(g + 1) & 64512) ? (l = 65536 + ((l & 1023) << 10) + (a.charCodeAt(++g) & 1023),
		        e[f++] = l >> 18 | 240,
		        e[f++] = l >> 12 & 63 | 128) : e[f++] = l >> 12 | 224,
		        e[f++] = l >> 6 & 63 | 128),
		        e[f++] = l & 63 | 128)
		    }
		    a = b;
		    for (f = 0; f < e.length; f++)
		        a += e[f],
		        a = tq(a, "+-a^+6");
		    a = tq(a, "+-3^+b+-f");
		    a ^= Number(d[1]) || 0;
		    0 > a && (a = (a & 2147483647) + 2147483648);
		    a %= 1000000;
		    return c + (a.toString() + "." + (a ^ b))
		};
		 
		/*--------------------------------------------------------------------------------
		参数：a 为你要翻译的原文
		其他外部函数：
		--------------------------------------------------------------------------------*/
		function sq(a) {
		    return function() {
		        return a
		    }
		}
		 
		function tq(a, b) {
		    for (var c = 0; c < b.length - 2; c += 3) {
		        var d = b.charAt(c + 2);
		        d = "a" <= d ? d.charCodeAt(0) - 87 : Number(d);
		        d = "+" == b.charAt(c + 1) ? a >>> d : a << d;
		        a = "+" == b.charAt(c) ? a + d & 4294967295 : a ^ d
		    }
		    return a
		}
        
        
        //生成url
        function generateGoogleTTSLink(q, tkk) {
            //var tk = calcHash(q, tkk);
            var tk = vq(q, tkk);
            return '/pdftranslate/translate/test?client=webapp&sl=en&tl=zh-CN&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=1&tk=' + tk + '&q=' + encodeURIComponent(q);
        }
        
        var httpRequest = new XMLHttpRequest();
        var tkk = '438202.813054333';
        function gotoUrl() {
        	console.log(textOutput.value);
        	console.log(tkk);
            var str = generateGoogleTTSLink(textOutput.value, tkk);
            httpRequest.open('GET', str, true);
            httpRequest.send();	
        }
		httpRequest.onreadystatechange = function showTranslate() {
            if(httpRequest.readyState==4 && httpRequest.status==200){  
                var json = httpRequest.responseText;
                json = JSON.parse(json);
                textTranslate.value = json.translate;
                console.log(json);
        	} 
		}
		function gettkk() {
	        var tkkRequest = new XMLHttpRequest();
            tkkRequest.open('GET', '/pdftranslate/translate/gettkk', true);
            tkkRequest.send();
            setTimeout(function(){
                var json = JSON.parse(tkkRequest.responseText);
                console.log(json);
    			tkk = json.tkk;
            	alert('初始化完成！');
            }, 2000);
		}
    </script>

</body>

</html>
