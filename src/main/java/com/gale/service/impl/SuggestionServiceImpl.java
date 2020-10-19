package com.gale.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gale.dao.SuggestionDao;
import com.gale.entity.Suggestion;
import com.gale.service.SuggestionService;
@Service
public class SuggestionServiceImpl implements SuggestionService {

	@Autowired
	private SuggestionDao suggestionDao;
	public Suggestion getByID(int id) {
		// TODO Auto-generated method stub
		return suggestionDao.queryByID(id);
	}
	public void addSuggestion(Suggestion suggestion) {
		// TODO Auto-generated method stub
		suggestionDao.addSuggestion(suggestion);
	}

	public void deleteSuggestion(int id) {
		// TODO Auto-generated method stub
		suggestionDao.deleteSuggestion(id);
	}

	public List<Suggestion> getList() {
		// TODO Auto-generated method stub
		return suggestionDao.queryAll(0, 1000);
	}

}
