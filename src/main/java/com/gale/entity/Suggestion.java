package com.gale.entity;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class Suggestion {
	private int id;
	private String suggestion;
	private Date time;
	public Suggestion() {
	}
	public Suggestion(String suggestion) {
		super();
		this.suggestion = suggestion;
		//this.time = time;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(new java.util.Date()));// new Date()为获取当前系统时间
        this.time = new Date((new java.util.Date()).getTime());
	}
	public Suggestion(int id, String suggestion, Date time) {
		super();
		this.id = id;
		this.suggestion = suggestion;
		this.time = time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSuggestion() {
		return suggestion;
	}
	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}
