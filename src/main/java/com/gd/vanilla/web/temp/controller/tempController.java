package com.gd.vanilla.web.temp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.vanilla.common.CommonProperties;
import com.gd.vanilla.common.bean.PagingBean;
import com.gd.vanilla.common.service.IPagingService;
import com.gd.vanilla.util.Utils;
import com.gd.vanilla.web.common.service.ICommonService;
import com.gd.vanilla.web.hr.service.IhrService;
import com.gd.vanilla.web.temp.service.ItempService;

@Controller
public class tempController {
	@Autowired 
	public ItempService itempService;
	
	@Autowired
	public ICommonService iCommonService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/schdlMngmnt")
	public ModelAndView emplyCard(HttpSession session, ModelAndView mav) {
		mav.setViewName("tempNotMerge/schdlMngmnt");
		return mav;
	}//schdlMngmnt end
	
}//hrController end
