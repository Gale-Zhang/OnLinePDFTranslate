package com.gale.service;

import java.util.List;

import com.gale.entity.Suggestion;

public interface SuggestionService {
	Suggestion getByID(int id);
	void addSuggestion(Suggestion suggestion);
	void deleteSuggestion(int id);
	List<Suggestion> getList();
}
