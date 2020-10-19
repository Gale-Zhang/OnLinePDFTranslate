package com.gale.web;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/translate")
public class translateController {
	//@RequestMapping(value = "/test", method = RequestMethod.GET)
	@RequestMapping(value = "/test", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)
	@ResponseBody
	private String translate(HttpServletRequest req) throws Exception {
		String url = "https://translate.google.cn/translate_a/single?";
		//System.out.println(tk + q);
		//url += "tk=" + tk + "&q=" + q.replace(" ", "%20");
		url += req.getQueryString();
		System.out.println(url);
		CloseableHttpClient client = null;
		CloseableHttpResponse response = null;
		String ret = new String();
		try {
			client = HttpClients.createDefault();
			HttpGet httpGet = new HttpGet(url);
			httpGet.setHeader(new BasicHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"));
			httpGet.setHeader(new BasicHeader("Accept", "application/json;charset=utf-8"));
			response = client.execute(httpGet);
			//int statusCode = response.getStatusLine().getStatusCode();
			//System.out.println(statusCode);
			HttpEntity entity = response.getEntity();
			//System.out.println(entity);
			String result = EntityUtils.toString(entity,"UTF-8");
			//System.out.println(result);			
			int start = 0;
	        int count = 3;
	        for(int i = 3; i < result.length(); i++) {
	            char c = result.charAt(i);
	            if(c == '[') 
	                count++;
	            else if(c == ']') {
	                count--;
	                if(count == 1)
	                	break;
	            } else if(c == '"' && count == 3) {
	                if(start == 0) {
	                    if(result.charAt(i - 1) == '[')
	                    	start = i;
	                }else {
	                    ret += result.substring(start + 1, i);
	                    start = 0;
	                }
	            }
	        }
			response.close();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"translate\":\"" + ret + "\"}";
	}

	@RequestMapping(value = "/gettkk", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)
	@ResponseBody
	private String gettkk() {
		String tkk = new String("438202.813054333");
		String url = "https://translate.google.cn";
		CloseableHttpClient client = null;
		CloseableHttpResponse response = null;
		try {
			client = HttpClients.createDefault();
			HttpGet httpGet = new HttpGet(url);
			httpGet.setHeader(new BasicHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"));
			httpGet.setHeader(new BasicHeader("Accept", "text/html;charset=utf-8"));
			response = client.execute(httpGet);
			//System.out.println(statusCode);
			HttpEntity entity = response.getEntity();
			//System.out.println(entity);
			String result = EntityUtils.toString(entity,"UTF-8");
			//System.out.println(result);
	        for(int i = 0; i + 4 < result.length(); i++) {
	        	if(result.substring(i, i + 4).equals("tkk:")) {
	        		int start = i + 4;
	        		int end = start + 1;
	        		while(result.charAt(end) != '\'')
	        			end++;
	        		tkk = result.substring(start + 1, end);
	        		//System.out.print(tkk);
	        		break;
	        	}
	        }
			response.close();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"tkk\":\"" + tkk + "\"}";
	}
}
