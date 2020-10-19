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
                    <!--  
                        <input class="tab-input" id="tabCh" type="radio" name="tabs" >
                        <label class="tab-label" for="tabCh" onclick="setMode(modeCh); checkChinese();">中文模式</label>-->
                        <input class="tab-input" id="tabEn" type="radio" name="tabs"checked>
                        <label class="tab-label" for="tabEn" onclick="setMode(modeEn); checkEnglish();">翻译模式</label>
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
	    		<textarea class="tx-area" id="text-translate"></textarea>
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
	
    <script type="text/javascript">

        var textInput = null;
        var textTranslate = null;
        var sentence = null; 

        window.onload = init;

        init();

        function init() {
            textInput = document.getElementById('text-input');
            textTranslate = document.getElementById('text-translate');
            
            textInput.placeholder = '- 来吧，往这粘';
            textTranslate.placeholder = '- 将会 去除换行符、规范空格、规范全角半角，并进行谷歌翻译';
            document.getElementById('autoCopy').checked = isAutoCopy();

            textInput.oninput = exec;
        }

        function exec() {
            textInput.focus();
            sentence = execEn(textInput.value);
            console.log(sentence);
            gotoUrl();
            if (isAutoCopy()) {
                copyOutput();
            }
        }

        var regexWhiteSpace = /\s/g;
        var regexMultiSpace = /\s+/g;

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
            textTranslate.value = '';
            textInput.focus();
        }

        function copyOutput() {
            if (textTranslate.value === '') {
                return;
            }

            textTranslate.select();
            document.execCommand('copy');
            textInput.focus();

            let copyText = document.getElementsByClassName('copy-text')[0];
            copyText.style.transition = '0s';
            copyText.style.opacity = 1;
            setTimeout(() => { copyText.style.transition = '1s'; copyText.style.opacity = 0; }, 2000);
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
            var tk = vq(q, tkk);
            return '/pdftranslate/translate/test?client=webapp&sl=en&tl=zh-CN&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=1&tk=' + tk + '&q=' + encodeURIComponent(q);
        }
        
        var httpRequest = new XMLHttpRequest();
        var tkk = '438202.813054333';
        function gotoUrl() {
        	console.log(sentence);
        	console.log(tkk);
            var str = generateGoogleTTSLink(sentence, tkk);
            httpRequest.open('GET', str, true);
            httpRequest.send();	
        }
		httpRequest.onreadystatechange = function showTranslate() {
            var json = httpRequest.responseText;
            json = JSON.parse(json);
            textTranslate.value = json.translate;
            console.log(json);
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
