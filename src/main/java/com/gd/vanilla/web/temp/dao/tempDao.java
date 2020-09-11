package com.gd.vanilla.web.temp.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class tempDao implements ItempDao {
	@Autowired 
	public SqlSession SqlSession;

	}
