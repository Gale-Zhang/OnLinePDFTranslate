package com.gale.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gale.entity.Suggestion;

public interface SuggestionDao {
	Suggestion queryByID(int sugID);
	void deleteSuggestion(int sugID);
	void addSuggestion(Suggestion sug);
	List<Suggestion> queryAll(@Param("offset")int offset, @Param("limit")int limit);
}
