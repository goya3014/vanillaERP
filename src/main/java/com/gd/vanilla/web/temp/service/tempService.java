package com.gd.vanilla.web.temp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.vanilla.web.temp.dao.ItempDao;

@Service
public class tempService implements ItempService {
	@Autowired 
	public ItempDao itempDao;

	}
