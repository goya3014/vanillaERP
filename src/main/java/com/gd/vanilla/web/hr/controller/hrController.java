package com.gd.vanilla.web.hr.controller;

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

@Controller
public class hrController {
	@Autowired
	public IhrService ihrService;
	
	@Autowired
	public ICommonService iCommonService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/emplyCard")
	public ModelAndView emplyCard(HttpSession session, ModelAndView mav) {
		mav.setViewName("hr/emplyCard");
		return mav;
	}//emplyCard end

	@RequestMapping(value = "/bscPrfrmncIndctr")
	public ModelAndView bscPrfrmncIndctr(@RequestParam HashMap<String,String> params, HttpSession session, ModelAndView mav) throws Throwable {
		
		//이번해가 셀렉트 연도 목록에 없으면 만들기 
		int thisYear;
		
		System.out.println("while before");
		while(true) {
			System.out.println("while");
			thisYear = ihrService.getStndrdBscNo(params);
			
			if(thisYear == 0) {
				System.out.println("write before");
				ihrService.writeStndrdBscNo(params);
				System.out.println("write after");
			} else {
				System.out.println("break");
				break;
			}
		}
		
		//셀렉트 연도 목록 불러서 보내기 
		List<HashMap<String,String>> list = ihrService.getBscStndYear(params);
		mav.addObject("list", list);
		//부서 목록 불러서 보내기 
		List<HashMap<String,String>> list2 = ihrService.getBscGbnDprtmnt(params);
		mav.addObject("list2", list2);

		/* params.put("bscDvsnThisYear", Integer.toString(thisYear)); */
		
		mav.setViewName("hr/bscPrfrmncIndctr");
		return mav;
	}//bscPrfrmncIndctr end
	
	@RequestMapping(value = "/config")
	public ModelAndView config(HttpSession session, ModelAndView mav) {
		
		mav.setViewName("hr/config");
		
		return mav;
	}//config end
	
	//로그인 아작스 
	@RequestMapping(value = "/loginPasswordAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String loginPasswordAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//패스워드 암호화
			params.put("psrd", Utils.encryptAES128(params.get("psrd")));
			HashMap<String, String> data = ihrService.myinfologinCheck(params);
			
			if(data != null && !data.isEmpty()) {
				modelMap.put("res","success");
			} else {
				modelMap.put("res","fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("res", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}//loginPasswordAjax

	//비밀번호수정 아작스 
	@RequestMapping(value = "/psrdchangeAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String psrdchangeAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//패스워드 암호화
			params.put("psrd", Utils.encryptAES128(params.get("psrd")));
			System.out.println(params.get("psrd"));
			int cnt = ihrService.psrdchange(params);
			
			if(cnt>0) {
				modelMap.put("res","success");
			} else {
				modelMap.put("res","fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("res", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}//psrdchangeAjax
	
	@RequestMapping(value = "/myinfo")
	public ModelAndView myinfo(@RequestParam HashMap<String,String> params, HttpSession session, ModelAndView mav) throws Throwable {
		
		if(params.get("checkEmplyNo") == null) {
			mav.setViewName("hr/config");
		} else {
			
			HashMap<String,String> data = ihrService.getEmply2(params);

			mav.addObject("data", data);
			
			mav.setViewName("hr/myinfo");
		}
		return mav;
	}//myInfo end
	
	//비밀번호 등 수정 아작스
	

	
	@RequestMapping(value = "/emplyCardAdd")
	public ModelAndView emplyCardAdd(HttpSession session, ModelAndView mav) {
		mav.setViewName("hr/emplyCardAdd");
		return mav;
	}//emplyCardAdd end
	
	
	
	@RequestMapping(value="/empListAjax", method=RequestMethod.POST,produces="text/json;charset=UTF-8")
	
	@ResponseBody
	public String empListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		try {
			int cnt = ihrService.getEmpCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")),cnt,10,5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String,String>> list = ihrService.getEmpList(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			modelMap.put("result","success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);
		
	}//empListAjax end
	
	

	@RequestMapping(value="/empNpListAjax", method=RequestMethod.POST,produces="text/json;charset=UTF-8")
	
	@ResponseBody
	public String empNpListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		try {
			List<HashMap<String,String>> list = ihrService.getEmpListNp(params);
			
			modelMap.put("list", list);
			
			modelMap.put("result","success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);
		
	}//empNpListAjax end
	
	//퇴사자 불러오는 아작스 
	@RequestMapping(value="/empOpListAjax", method=RequestMethod.POST,produces="text/json;charset=UTF-8")
	
	@ResponseBody
	public String empOpListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		try {
			List<HashMap<String,String>> list = ihrService.getEmpListOp(params);
			
			modelMap.put("list", list);
			modelMap.put("result","success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);
		
	}//empOpListAjax end
	
	@RequestMapping(value="/empWriteAjax", method = RequestMethod.POST, //포스트만 받겠다.
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String empWriteAjax(@RequestParam HashMap<String,String> params,
							ModelAndView modelAndView) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int res = 0;
		
		try {
			
			String empPw = params.get("pswrd");
			empPw = Utils.encryptAES128(empPw);
			params.put("pswrd", empPw);
			
			int cnt = ihrService.getEmpEmailCheck(params);
			
			if(cnt>0) {
				
			res = 1;
			modelMap.put("result", "exception");
				
			} else {
				
			ihrService.empWrite(params);
			modelMap.put("result", "success");
			
			}
		} catch(Throwable e) {
			
			res = 2;

			e.printStackTrace();
			modelMap.put("result", "exception");
			
		}
		
		System.out.println(mapper.writeValueAsString(modelMap));
		//writeValueAsString : 값을 문자열로 변환(JSON 형태)
		return mapper.writeValueAsString(modelMap);
		
	}//empWriteAjax

	
	
	@RequestMapping(value = "/emplyCardRead")
	public ModelAndView emplyCardRead(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		HashMap<String,String> data = ihrService.getEmply(params);
		
		mav.addObject("data", data);
		mav.setViewName("hr/emplyCardRead");
		
		return mav;
	}//emplyCardRead 상세읽기

	@RequestMapping(value = "/myinfo2")
	public ModelAndView myinfo2(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		if(params.get("checkEmplyNo") == null) {
			mav.setViewName("hr/config");
		} else {
			
			HashMap<String,String> data = ihrService.getEmply(params);
			
			mav.addObject("data", data);
			mav.setViewName("hr/myinfo2");
		}
		return mav;
		

	}//myinfo2 상세읽기
	
	@RequestMapping(value = "/emplyCardUpdate")
	public ModelAndView emplyCardUpdate(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		
		HashMap<String,String> data = ihrService.getEmply2(params);
		
		mav.addObject("data", data);
		mav.setViewName("hr/emplyCardUpdate");
		
		return mav;
	}//

	@RequestMapping(value = "/prsnlDcmntUpdate")
	public ModelAndView prsnlDcmntUpdate(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		
		HashMap<String,String> data = ihrService.getpd(params);
		
		mav.addObject("data", data);
		mav.setViewName("hr/prsnlDcmntUpdate");
		
		return mav;
	}//
	
	
	
	@RequestMapping(value="/pdUpdateAjax", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	
	
	@ResponseBody
	public String pdUpdateAjax(@RequestParam HashMap<String,String> params) throws Throwable { //params 받아오기 
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		try {
			
				int cnt = ihrService.pdUpdate(params);
				
				if(cnt > 0) {
					
					
					//html로 기안내용 - 기안/결재 테이블 넘기기 
					HashMap<String,String> list = ihrService.getpd(params);
								
					String html = "";
					html += "<div class=\"docWrap\" style=\"border:1px solid gray;font-size:11pt;\">";
					html += "<table style=\"width:100%; text-indent: 15px;\">";
					html += "<colgroup><col width=\"10%\">	<col width=\"50%\">	</colgroup>";
					html += "<tbody>	<tr style=\"height:45px;\">		<td style=\"background-color:#00305a; color: white;\">작성일자</td>	<td>" + list.get("WRT_DATE") + "</td>	</tr>";
					html += "<tr style=\"height:45px;\">	<td style=\"background-color:#00305a; color: white;\">작성자</td>	<td>" + list.get("WRTR_NAME") + "</td>		</tr>";
					html += "<tr style=\"height:100px;\">	<td></td>		<td><b>" + list.get("PRSNL_DCMNT_KIND") + "</b></td>	</tr>";
					html += "<tr style=\"height:45px;\">	<td style=\"background-color:#00305a; color: white;\">요청자</td>	<td>" + list.get("EMPLY_NAME") + "</td>		</tr>";
					html += "<tr style=\"height:45px;\"><td style=\"background-color:#00305a; color: white;\">기간</td>";
					html += "<td>" + list.get("START_DAY_Y") + "년  " + list.get("START_DAY_M") + "월 " + list.get("START_DAY_D") + "일 부터 " + list.get("END_DAY_Y") + "년 " + list.get("END_DAY_M") + "월 " + list.get("END_DAY_D") + "일 까지</td>	</tr>";
					html += "<tr style=\"height:45px;\"><td style=\"background-color:#00305a; color: white;\">용도</td>	<td>" + list.get("DCMNT_USE") + "</td>	</tr>";
					html += "<tr style=\"height:100px;\">	<td></td>		<td>위 사항의 증명을 결재 신청합니다</td>	</tr>";
					html += "</tbody>			 </table>			 </div>";
					
					params.put("draftHtml", html);
					
					int draftNoFS = ihrService.getdraftNoForUpdate(params);
					params.put("draftNoFS", Integer.toString(draftNoFS));

					//결재문서종류번호 - 인사서류 등록
					int cnt2 = ihrService.draftUpdate(params);
					
					if(cnt2>0) {
						modelMap.put("result", "success");
					} else {
						modelMap.put("result", "fail3");
					}
				} else {
					modelMap.put("result", "fail2");
				}
				
		} catch(Throwable e) {
			
			e.printStackTrace();
			modelMap.put("result", "exception");
			
		}
		
		System.out.println(mapper.writeValueAsString(modelMap));
		//writeValueAsString : 값을 문자열로 변환(JSON 형태)
		return mapper.writeValueAsString(modelMap);
		
	}//pdUpdateAjax

	
	@RequestMapping(value="/empUpdateAjax", method = RequestMethod.POST, 
	produces = "text/json;charset=UTF-8")


	@ResponseBody
	public String empUpdateAjax(@RequestParam HashMap<String,String> params) throws Throwable { //params 받아오기 
		
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	

	try {
		
		int cnt = ihrService.getEmpEmailCheck2(params); //이메일 중복 확인
		
		if(cnt > 0) {
			
			modelMap.put("result", "fail"); 
			
		} else {
			
			int cnt2 = ihrService.empUpdate(params);
			
			if(cnt2 > 0) {
				modelMap.put("result", "success");
			} else {
				modelMap.put("result", "fail2");
			}
		
		}
		
	} catch(Throwable e) {
		
		e.printStackTrace();
		modelMap.put("result", "exception");
		
	}
	
	System.out.println(mapper.writeValueAsString(modelMap));
	//writeValueAsString : 값을 문자열로 변환(JSON 형태)
	return mapper.writeValueAsString(modelMap);
	
}//empUpdateAjax
	
	
	

	@RequestMapping(value = "/prsnlDcmnt")
	public ModelAndView prsnlDcmnt(HttpSession session, ModelAndView mav) {
		mav.setViewName("hr/prsnlDcmnt");
		return mav;
	}//prsnlDcmnt end

	@RequestMapping(value = "/prsnlDcmntRead")
	public ModelAndView prsnlDcmntRead(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{

		HashMap<String,String> data = ihrService.getpd(params);
		HashMap<String,String> cndtn = ihrService.getpdCondition(params);
		
		mav.addObject("data", data);
		mav.addObject("cndtn", cndtn);
		mav.setViewName("hr/prsnlDcmntRead");
		
		return mav;
		
	}//prsnlDcmntRead end
	
	//인사서류 새로 신규 작성시 해당 사람 불러오기 
		@RequestMapping(value = "/prsnlDcmntWrite")
		public ModelAndView prsnlDcmntWrite(@RequestParam HashMap<String,String> params, HttpSession session, ModelAndView mav) throws Throwable{
			
			HashMap<String,String> data = ihrService.getAllEmply(params);
			HashMap<String,String> nextNo = ihrService.getPdNextvalNo(params);
			
			mav.addObject("data", data);
			mav.addObject("nextNo", nextNo);
			mav.setViewName("hr/prsnlDcmntWrite");
			return mav;
		}//prsnlDcmntWrite end
		
	@RequestMapping(value="/pdListAjax", method=RequestMethod.POST,produces="text/json;charset=UTF-8")
	
	@ResponseBody
	public String pdListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		try {
			int cnt = ihrService.getpdListcnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")),cnt,10,5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String,String>> list = ihrService.getpdList(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			modelMap.put("result","success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);
		
	}//pdListAjax end

	
	@RequestMapping(value="/bscListAjax", method=RequestMethod.POST,produces="text/json;charset=UTF-8")
	
	@ResponseBody
	public String bscListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		try {
			int cnt = ihrService.getbsclistcnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")),cnt,10,5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String,String>> list = ihrService.getbsclist(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			modelMap.put("result","success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);
		
	}//bscListAjax end
	
	
	 @RequestMapping(value="/adrsUpdateAjax", method = RequestMethod.POST,
	 produces = "text/json;charset=UTF-8")
	  
	  @ResponseBody public String adrsUpdateAjax(@RequestParam
	  HashMap<String,String> params) throws Throwable { //params 받아오기
	  
	  ObjectMapper mapper = new ObjectMapper(); Map<String, Object> modelMap = new
	  HashMap<String, Object>();
	  
	  
	  try {
	  
	  
		  int cnt = ihrService.forPdoWriteUpdateEmplyAdrs(params);
	  
		  
		  if(cnt > 0) { 
			  
			  HashMap<String,String> one = ihrService.onlyAdrs(params);
				
			  modelMap.put("one", one);
			  modelMap.put("result", "success"); 
		  
		  } else {
			  
			  modelMap.put("result", "fail"); 
		  }
	  
	  } catch(Throwable e) {
	  
	  e.printStackTrace(); modelMap.put("result", "exception");
	  
	  }
	  
	  System.out.println(mapper.writeValueAsString(modelMap)); return
	  mapper.writeValueAsString(modelMap);
	  
	  }//adrsUpdateAjax

	 @RequestMapping(value="/pdWriteAjax", method = RequestMethod.POST,
			 produces = "text/json;charset=UTF-8")
	 
	 @ResponseBody public String pdWriteAjax(@RequestParam HashMap<String,String> params) throws Throwable { //params 받아오기
		 
		 ObjectMapper mapper = new ObjectMapper(); 
		 Map<String, Object> modelMap = new HashMap<String, Object>();
		 
		 try {
			
			 
			ihrService.pdWrite(params);
			System.out.println("checkDocNo : " + params.get("checkDocNo"));
			
			 
			//html로 기안내용 - 기안/결재 테이블 넘기기 
			HashMap<String,String> list = ihrService.getpd(params);
						
			String html = "";
			html += "<div class=\"docWrap\" style=\"border:1px solid gray;font-size:11pt;\">";
			html += "<table style=\"width:100%; text-indent: 15px;\">";
			html += "<colgroup><col width=\"10%\">	<col width=\"50%\">	</colgroup>";
			html += "<tbody>	<tr style=\"height:45px;\">		<td style=\"background-color:#00305a; color: white;\">작성일자</td>	<td>" + list.get("WRT_DATE") + "</td>	</tr>";
			html += "<tr style=\"height:45px;\">	<td style=\"background-color:#00305a; color: white;\">작성자</td>	<td>" + list.get("WRTR_NAME") + "</td>		</tr>";
			html += "<tr style=\"height:100px;\">	<td></td>		<td><b>" + list.get("PRSNL_DCMNT_KIND") + "</b></td>	</tr>";
			html += "<tr style=\"height:45px;\">	<td style=\"background-color:#00305a; color: white;\">요청자</td>	<td>" + list.get("EMPLY_NAME") + "</td>		</tr>";
			html += "<tr style=\"height:45px;\"><td style=\"background-color:#00305a; color: white;\">기간</td>";
			html += "<td>" + list.get("START_DAY_Y") + "년  " + list.get("START_DAY_M") + "월 " + list.get("START_DAY_D") + "일 부터 " + list.get("END_DAY_Y") + "년 " + list.get("END_DAY_M") + "월 " + list.get("END_DAY_D") + "일 까지</td>	</tr>";
			html += "<tr style=\"height:45px;\"><td style=\"background-color:#00305a; color: white;\">용도</td>	<td>" + list.get("DCMNT_USE") + "</td>	</tr>";
			html += "<tr style=\"height:100px;\">	<td></td>		<td>위 사항의 증명을 결재 신청합니다</td>	</tr>";
			html += "</tbody>			 </table>			 </div>";
			
			params.put("draftHtml", html);
			
			//인사서류 sEmplyNo가 쓴 것중 Max 가져와서 draftNo params.put 하기 
			int draftNo = ihrService.getDraftNo(params);
			params.put("draftNo", Integer.toString(draftNo));
			System.out.println(draftNo);
			
			//결재문서종류번호 - 인사서류 등록
			ihrService.draftWrite(params);
			//결재 받을 사람: 인사부장 - 결재 테이블 사원번호 = 결재자 
			params.put("dNo",String.valueOf(list.get("D_NO")));
			ihrService.signWrite(params);
			
			
			//결재 되면 내거에 어떻게 연결되는지 확인
			//결재번호 결재일 - read 할때 가져오기 
			//반려는 어떤 조건인지 알아와서 적용하기 
			 
			modelMap.put("result", "success");  
			 
			
		 } catch(Throwable e) {
			 
			 e.printStackTrace(); modelMap.put("result", "exception");
			 
		 }
		 
		 System.out.println(mapper.writeValueAsString(modelMap)); 
		 return mapper.writeValueAsString(modelMap);
		 
	 }//pdWriteAjax
	 	
	 @RequestMapping(value="/adtnalDutyMngmnt")
		public ModelAndView adtnalDutyMngmnt(HttpSession session, ModelAndView mav) {
			
			try {
				String athrytyType = iCommonService.menuAthrtyCheck(String.valueOf(session.getAttribute("sAthrtyNo")), "39");
				
				mav.addObject("athrytyType", athrytyType);//jsp에서 코어태그 if로 처리해주기
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			mav.setViewName("hr/adtnalDutyMngmnt");
			return mav;
		}
		
		@RequestMapping(value="/adtWriteAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String adtWriteAjax(@RequestParam HashMap<String, String> params,
				 ModelAndView modelAndView) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				ihrService.adtWrite(params);
				modelMap.put("result", "success");
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			
			System.out.println(mapper.writeValueAsString(modelMap));
			return mapper.writeValueAsString(modelMap);
		}
		
		
		@RequestMapping(value="/adtListAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String adtListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				
				List<HashMap<String, String>> list = ihrService.adtList(params);
				list = Utils.toLowerListMapKeyCamel(list);
				modelMap.put("list", list);
				modelMap.put("result", "success");
				
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			return mapper.writeValueAsString(modelMap);
		}
		
		
		@RequestMapping(value="/adtnalDutySttstcs")
		public ModelAndView adtnalDutySttstcs(ModelAndView mav) {
			
			mav.setViewName("hr/adtnalDutySttstcs");
			return mav;
		}
		
		@RequestMapping(value="/getChartAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String getChartAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				
				List<HashMap<String, String>> list = ihrService.getChartAjax(params);
				
				modelMap.put("list", list);
				modelMap.put("result", "success");
				
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			return mapper.writeValueAsString(modelMap);
		}
		
			  
		  @RequestMapping(value="/getPUListAjax", method = RequestMethod.POST, produces
				  = "text/json;charset=UTF-8")
		  
		  @ResponseBody public String getPUListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			  
			  ObjectMapper mapper = new ObjectMapper(); Map<String, Object> modelMap = new
					  HashMap<String, Object>();
			  
			  try {
				  
				  List<HashMap<String, String>> list = ihrService.getPUList(params); 
				  
				  modelMap.put("list", list);
				  modelMap.put("result", "success");
				  
			  }catch(Throwable e){
				  
				  e.printStackTrace();
				  modelMap.put("result", "exception"); 
				  
			  }
			  return mapper.writeValueAsString(modelMap); 
		  }
		 
		
			@RequestMapping(value="/adtUpdateAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
			
			@ResponseBody
			public String adtUpdateAjax(@RequestParam HashMap<String, String> params) throws Throwable {
				
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {//update는 resultType 주지 않아도 int를 반환함.
					int cnt = ihrService.adtUpdate(params);
					
					if(cnt > 0) {
						modelMap.put("result", "success");
					}else {
						modelMap.put("result", "fail");
					}
				}catch(Throwable e){
					e.printStackTrace();
					modelMap.put("result", "exception");
				}
				return mapper.writeValueAsString(modelMap);
			}
			
		
			@RequestMapping(value="/adtDeleteAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
			@ResponseBody
			public String adtDeleteAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
				
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					
					int cnt = ihrService.adtDelete(params);
					
					if(cnt > 0) {
						modelMap.put("result", "success");
					}else {
						modelMap.put("result", "fail");
					}
							
				}catch(Throwable e){
					e.printStackTrace();
					modelMap.put("result", "exception");
				}
				return mapper.writeValueAsString(modelMap);
			}
	
			@RequestMapping(value = "/groupChart")
			public ModelAndView hrgroupChart(HttpSession session, ModelAndView mav) throws Throwable {
				
				try { 
					String athrtyNo = iCommonService.menuAthrtyCheck(String.valueOf(session.getAttribute("sAthrtyNo")), "49");
					mav.addObject("athrtyNo", athrtyNo);
				}catch(Exception e) {
					e.printStackTrace();
				}

				mav.setViewName("hr/groupChart");

				return mav;
			}
			
			/* 수정/삭제 권한 부여하기  */
			


			@RequestMapping(value = "/getgroupChartAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
			@ResponseBody
			public String getChartAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {

				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();

				List<HashMap<String, String>> groupChart = ihrService.getChart();

				groupChart = Utils.toLowerListMapKeyCamel(groupChart);

				modelMap.put("groupChart", groupChart);

				return mapper.writeValueAsString(modelMap);
			}

			@RequestMapping(value = "/groupwrite")
			public ModelAndView groupWrite(ModelAndView mav) {

				return mav;
			}

			@RequestMapping(value = "/insertGroupAjax", method = RequestMethod.POST, produces = "test/json;charset=UTF-8")
			@ResponseBody
			public String insertGroupAjax(@RequestParam HashMap<String, String> params, HttpSession session,
					ModelAndView modelAndView) throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();

				try {
					ihrService.groupwrite(params);
					modelMap.put("result", "success");
				} catch (Throwable e) {
					e.printStackTrace();
					modelMap.put("result", "exception");
				}
				System.out.println(mapper.writeValueAsString(modelMap));

				return mapper.writeValueAsString(modelMap);
			}

			@RequestMapping(value = "/deleteGroupAjax", method = RequestMethod.POST, produces = "test/json;charset=UTF-8")
			@ResponseBody
			public String deleteGroupAjax(@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();

				try {
					int cnt = ihrService.getgroup(params);
					
					if(cnt <= 0 ) {
						int cnt2 = ihrService.groupupdateYn(params);
						modelMap.put("result","success");
					} else {
						modelMap.put("result","fail");
					}
				} catch (Throwable e) {
					e.printStackTrace();
					modelMap.put("result", "exception");
				}

				return mapper.writeValueAsString(modelMap);
			}
			
			// 사원 조회
			
			@RequestMapping(value= "/getemplyAjax", method = RequestMethod.POST,
					produces = "test/json;charset=UTF-8")
				@ResponseBody
				public String getemplyAjax(@RequestParam HashMap<String, String> params) throws Throwable {
				ObjectMapper mapper = new ObjectMapper();
				Map<String, Object> modelMap = new HashMap<String, Object>();
				
				try {
					int cnt = ihrService.getempCnt(params);
					
					PagingBean pb 
					= iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);
					
					params.put("startCnt", Integer.toString(pb.getStartCount()));
					params.put("endCnt", Integer.toString(pb.getEndCount()));
					
					List<HashMap<String,String>> list = ihrService.getempList(params);
					
					modelMap.put("list",list);
					modelMap.put("pb",pb);
					modelMap.put("result","success");

				} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result","exception");
				}
				
				return mapper.writeValueAsString(modelMap);
			}		
			
	//휴가 신청서
	@RequestMapping(value = "/vctnMngmnt")
	public ModelAndView vctnMngmnt(HttpSession session, ModelAndView mav) throws Throwable {

		mav.setViewName("hr/vctnMngmnt");

		return mav;
	}
	
	//휴가 조회 
	@RequestMapping(value = "/vctnSrch")
	public ModelAndView vctnSrch(HttpSession session, ModelAndView mav) throws Throwable {

		mav.setViewName("hr/vctnSrch");

		return mav;
	}
	
	//인사발령
	@RequestMapping(value = "/prsnlApntmnts")
	public ModelAndView prsnlApntmnts(HttpSession session, ModelAndView mav) throws Throwable {
		
		/* 권한주기
		 * try { String athrtyNo =
		 * commonService.menuAthrtyCheck(String.valueOf(session.getAttribute("sAthrtyNo"
		 * )),"43"); mav.addObject("athrtyNo", athrtyNo); } catch(Exception e) {
		 * e.printStackTrace(); }
		 */

		mav.setViewName("hr/prsnlApntmnts");

		return mav;
	}
	
	//검색 (수정해야됨)
	@RequestMapping(value="/prsnlApntmntsAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String prsnlApntmntsAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = ihrService.getdprtCnt(params);
			System.out.println(params);
			PagingBean pb 
			= iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5); 
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String, String>> list = ihrService.getdprtList(params);
			System.out.println(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("result", "success");
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//사원 목록 조회 
	@RequestMapping(value="/empsrchAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String empsrchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			List<HashMap<String, String>> list = ihrService.empsrchList(params);
			
			modelMap.put("list", list);
			
			modelMap.put("result", "success");
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	// 팝업 1에 사원 띄우기
	@RequestMapping(value="/prsnempAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String prsnempAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> data = ihrService.prsnempList(params);
			
			modelMap.put("data", data);
			modelMap.put("result", "success");
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	// 직급 옵션
	@RequestMapping(value="/popupPstnListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String popupPstnListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			List<HashMap<String, String>> list = ihrService.empjnameList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	// 부서 옵션
	@RequestMapping(value="/popupDprtmntListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String popupDprtmntListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			List<HashMap<String, String>> list = ihrService.empbnameList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//팝업안에 부서목록 띄우기
	@RequestMapping (value="/pstnsrchAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String pstnsrchAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			List<HashMap<String, String>> list = ihrService.pstnsrchList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			System.out.println(list);
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//결재
	
	@RequestMapping (value="/signinsertAjax",method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String signinsertAjax(@RequestParam HashMap<String, String> params,
			 ModelAndView modelAndView) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			ihrService.signinsert(params);
			modelMap.put("result", "success");
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		//writeValueAsString : 값을 문자열로 변환(JSON형태)
		System.out.println(mapper.writeValueAsString(modelMap));
		return mapper.writeValueAsString(modelMap);
	}
//----------------------------------------------------------------------------	
	@RequestMapping(value="/vctnwrtAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String vctnwrtAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			List<HashMap<String, String>> list = ihrService.vctnkindList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		}catch(Throwable e){
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//휴가조회
	@RequestMapping(value="/getListVctnAjax", method = RequestMethod.POST, produces
			  = "text/json;charset=UTF-8")
	  
	  @ResponseBody public String getListVctnAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		  
		  ObjectMapper mapper = new ObjectMapper();
		  Map<String, Object> modelMap = new HashMap<String, Object>();
		  
		  try {
			  
			  List<HashMap<String, String>> list = ihrService.getListVctn(params); 
			  
			  modelMap.put("list", list);
			  modelMap.put("result", "success");
			  
		  }catch(Throwable e){
			  
			  e.printStackTrace();
			  modelMap.put("result", "exception"); 
			  
		  }
		  return mapper.writeValueAsString(modelMap); 
	  }

	 @RequestMapping(value="/getSpListAjax", method = RequestMethod.POST, produces
			 = "text/json;charset=UTF-8")
	 
	 @ResponseBody public String getSpListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		 
		 ObjectMapper mapper = new ObjectMapper();
		 Map<String, Object> modelMap = new HashMap<String, Object>();
		 
		 try {
			 
			 List<HashMap<String, String>> list = ihrService.getSpList(params); 
			 
			 modelMap.put("list", list);
			 modelMap.put("result", "success");
			 
		 }catch(Throwable e){
			 
			 e.printStackTrace();
			 modelMap.put("result", "exception"); 
			 
		 }
		 return mapper.writeValueAsString(modelMap); 
	 }
	 // 휴가종류선택
	 @RequestMapping(value="/vctnWriteAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String vctnWriteAjax(@RequestParam HashMap<String, String> params,
				 ModelAndView modelAndView) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				ihrService.vctnadtWrite(params);
				modelMap.put("result", "success");
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			
			System.out.println(mapper.writeValueAsString(modelMap));
			return mapper.writeValueAsString(modelMap);
		}
	 
	 @RequestMapping(value="/vctnKindListAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String vctnKindListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
									
				List<HashMap<String, String>> vctn = ihrService.getVctnKindList(params);
				
				modelMap.put("vctn", vctn);
				modelMap.put("result", "success");
				
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			return mapper.writeValueAsString(modelMap);
		}
	 
	 @RequestMapping(value="/vctnInsertAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String vctnInsertAjax(@RequestParam HashMap<String, String> params,
				 ModelAndView modelAndView) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				ihrService.vctnInsertWrite(params);
				modelMap.put("result", "success");
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			
			System.out.println(mapper.writeValueAsString(modelMap));
			return mapper.writeValueAsString(modelMap);
		}
	
	 @RequestMapping(value="/indvdlvctnKindListAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String indvdlvctnKindListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
									
				List<HashMap<String, String>> vctn = ihrService.getindvdlvctnKindList(params);
				
				modelMap.put("vctn", vctn);
				modelMap.put("result", "success");
				
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			return mapper.writeValueAsString(modelMap);
		}
	 
	 @RequestMapping(value="/useVctnListAjax", method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String useVctnListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
									
				List<HashMap<String, String>> vctn = ihrService.useVctnList(params);
				
				modelMap.put("vctn", vctn);
				modelMap.put("result", "success");
				
			}catch(Throwable e){
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			return mapper.writeValueAsString(modelMap);
		}
	 
	 @RequestMapping(value = "/csfIndctrMngmnt")
		public ModelAndView csfIndctrMngmnt(@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable {
			
			
			HashMap<String,String> vwpntNext = ihrService.getVwpntnumber(params);
			if(vwpntNext.get("VWPNTCNT") == "0") {
				mav.addObject("vwpntNext",1);
			} else {
				mav.addObject("vwpntNext",vwpntNext.get("VWPNTNEXT"));
			}
			
			HashMap<String,String> csfNext = ihrService.getCsfnumber(params);
			if(csfNext.get("CSFCNT") == "0") {
				mav.addObject("csfNext",1);
			} else {
				mav.addObject("csfNext",csfNext.get("CSFNEXT"));
			}

			mav.setViewName("hr/csfIndctrMngmnt");

			return mav;
		}// csfWrite
		
		@RequestMapping(value = "/vwpntNameAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		
		// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
		@ResponseBody
		public String vwpntNameAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
			// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				String vwpntName = ihrService.getvwpntName(params);
				
				modelMap.put("vwpntName", vwpntName);
				modelMap.put("result", "success");
			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			System.out.println(mapper.writeValueAsString(modelMap));
			// writeValueAsString : 값을 문자열로 변환(JSON형태)
			return mapper.writeValueAsString(modelMap);
		}//vwpntNameAjax
		

		@RequestMapping(value = "/csfWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

		// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
		@ResponseBody
		public String csfWriteAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
			// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			

			try {
				ihrService.csfWrite(params);

				modelMap.put("result", "success");
			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			System.out.println(mapper.writeValueAsString(modelMap));
			// writeValueAsString : 값을 문자열로 변환(JSON형태)
			return mapper.writeValueAsString(modelMap);
		}
		
		@RequestMapping(value = "/vwpntWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		
		// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
		@ResponseBody
		public String vwpntWriteAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
			// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				ihrService.vwpntWrite(params);
				
				modelMap.put("result", "success");
			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			System.out.println(mapper.writeValueAsString(modelMap));
			// writeValueAsString : 값을 문자열로 변환(JSON형태)
			return mapper.writeValueAsString(modelMap);
		}

		@RequestMapping(value = "/csfListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

		@ResponseBody
		public String csfListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			try {

				int cnt = ihrService.getcsfCnt(params);
				PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);// viewCnt,
																												// pageCnt);
				params.put("startCnt", Integer.toString(pb.getStartCount()));
				params.put("endCnt", Integer.toString(pb.getEndCount()));

				List<HashMap<String, String>> list = ihrService.getcsfList(params);

				modelMap.put("list", list);
				modelMap.put("pb", pb);
				modelMap.put("result", "success");

			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}

			return mapper.writeValueAsString(modelMap);// 문자열을
		}// csfListAjax
		
		@RequestMapping(value = "/vwpntListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String vwpntListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
			
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				
				List<HashMap<String, String>> list = ihrService.getvwpntList(params);
				
				modelMap.put("list", list);
				modelMap.put("result", "success");
				
			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}
			
			return mapper.writeValueAsString(modelMap);// 문자열을
		}// vwpntListAjax
		
		@RequestMapping(value = "/csfdelAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		
		@ResponseBody
		public String csfdelAjax(@RequestParam HashMap<String, Object> params, @RequestParam List<Integer> chk, HttpSession session) throws Throwable {

			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			int cnt = 0;
			
			try {
				params.put("chk", chk);
				
	        	cnt = ihrService.csfdel(params); //where csf_no = #{deleteCsf}
			        	

				if (cnt > 0) {
					modelMap.put("result", "success");
				} else {
					modelMap.put("result", "fail");
				}

			} catch (Throwable e) {
				e.printStackTrace();
				modelMap.put("result", "exception");
			}

			return mapper.writeValueAsString(modelMap);// 문자열을
		}// csfDelAjax
		
	//*****kpiMngmnt******
		
		@RequestMapping(value = "/kpiMngmnt")
		public ModelAndView kpiMngmnt(@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable {

			HashMap<String,String> kpiNext = ihrService.getKpinumber(params);
			if(kpiNext.get("KPICNT") == "0") {
				mav.addObject("kpiNext",1);
			} else {
				mav.addObject("kpiNext",kpiNext.get("KPINEXT"));
			}
				
			mav.setViewName("hr/kpiMngmnt");

			return mav;
		}// kpiMngmnt
			

	@RequestMapping(value = "/kpiListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpiListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {

			int cnt = ihrService.getkpiCnt(params);
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);// viewCnt,
																											// pageCnt);
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));

			List<HashMap<String, String>> list = ihrService.getkpiList(params);

			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("result", "success");

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}

		return mapper.writeValueAsString(modelMap);// 문자열을
	}// kpiListAjax

	@RequestMapping(value = "/kpicsfListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpicsfListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			List<HashMap<String, String>> list = ihrService.getkpicsfList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);// 문자열을
	}//kpicsfListAjax

	@RequestMapping(value = "/kpiindctorListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpiindctorListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			List<HashMap<String, String>> list = ihrService.getkpiindctorList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);// 문자열을
	}//kpiindctorListAjax

	@RequestMapping(value = "/csfNameAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String csfNameAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> csfName = ihrService.getcsfName(params);
			
			modelMap.put("csfName", csfName);
			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//csfnameAjax


	@RequestMapping(value = "/indctorNameAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String indctorNameAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> indctorName = ihrService.getindctorName(params);
			
			modelMap.put("indctorName", indctorName);
			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//indctorNameAjax

	@RequestMapping(value = "/kpiWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String kpiWriteAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		

		try {
			ihrService.kpiWrite(params);

			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//kpiWriteAjax

	@RequestMapping(value = "/kpidelAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpidelAjax(@RequestParam HashMap<String, Object> params, @RequestParam List<Integer> chk2, HttpSession session) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			params.put("chk2", chk2);
			
	    	cnt = ihrService.kpidel(params); //where kpi_no = #{deletekpi}
		        	

			if (cnt > 0) {
				modelMap.put("result", "success");
			} else {
				modelMap.put("result", "fail");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}

		return mapper.writeValueAsString(modelMap);// 문자열을
	}// kpiDelAjax


	//*****kpiIndctrMngmnt******

	@RequestMapping(value = "/kpiIndctrMngmnt")
	public ModelAndView kpiIndctrMngmnt(@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable {
		
		mav.setViewName("hr/kpiIndctrMngmnt");

		return mav;
	}// kpiIndctrMngmnt

	@RequestMapping(value = "/indctorNumAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String indctorNumAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			HashMap<String,String> indctorNext = ihrService.getindctornumber(params);
			if(indctorNext.get("INDCTORCNT") == "0") {
				modelMap.put("indctorNext",1);
			} else {
				modelMap.put("indctorNext",indctorNext.get("INDCTORNEXT"));
			}
			
			modelMap.put("result", "success");
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);// 문자열을
	}// indctorNumAjax

	@RequestMapping(value = "/indctorListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String indctorListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {

			int cnt = ihrService.getindctorCnt(params);
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);// viewCnt,
																											// pageCnt);
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));

			List<HashMap<String, String>> list = ihrService.getindctorList(params);

			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("result", "success");

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}

		return mapper.writeValueAsString(modelMap);// 문자열을
	}// indctorListAjax


	@RequestMapping(value = "/indctorWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	//ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String indctorWriteAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		

		try {
			ihrService.indctorWrite(params);

			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//indctorWriteAjax

	//*****kpiIndctrAlctn******

	@RequestMapping(value = "/kpiIndctrAlctn")
	public ModelAndView kpiIndctrAlctn(@RequestParam HashMap<String, String> params,ModelAndView mav) throws Throwable {
		
		   int thisYear;
		      
		      System.out.println("while before");
		      while(true) {
		         System.out.println("while");
		         thisYear = ihrService.getStndrdBscNo(params);
		         
		         if(thisYear == 0) {
		            System.out.println("write before");
		            ihrService.writeStndrdBscNo(params);
		            System.out.println("write after");
		         } else {
		            System.out.println("break");
		            break;
		         }
		      }
		

		int yyyy = ihrService.getBscStdNo(params);
		mav.addObject("yyyy", yyyy);
		
		HashMap<String,String> bscNext = ihrService.getBscnumber(params);
		if(bscNext.get("BSCCNT") == "0") {
			mav.addObject("bscNext",1);
		} else {
			mav.addObject("bscNext",bscNext.get("BSCNEXT"));
		}
		
		
		
		mav.setViewName("hr/kpiIndctrAlctn");

		return mav;
	}// kpiIndctrAlctn

	@RequestMapping(value = "/kpihdListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpihdListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {

			int cnt = ihrService.getkpihdCnt(params);
			PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt, 10, 5);// viewCnt,
																											// pageCnt);
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));

			List<HashMap<String, String>> list = ihrService.getkpihdList(params);

			modelMap.put("list", list);
			modelMap.put("pb", pb);
			modelMap.put("result", "success");

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}

		return mapper.writeValueAsString(modelMap);// 문자열을
	}// kpihdListAjax

	@RequestMapping(value = "/kpiIndcListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String kpiIndcListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			List<HashMap<String, String>> list = ihrService.getkpiIndcList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		
		return mapper.writeValueAsString(modelMap);// 문자열을
	}//kpiIndcListAjax


	@RequestMapping(value = "/kpiIndcNameAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	//ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String kpiIndcNameAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> kpiName = ihrService.getkpiindctorName(params);
			
			modelMap.put("kpiName", kpiName);
			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//kpiIndcNameAjax


	@RequestMapping(value = "/goalWriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	//ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String goalWriteAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		

		try {
			ihrService.goalWrite(params);

			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//goalWriteAjax

	@RequestMapping(value = "/popupNameAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	//ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String popupNameAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			HashMap<String, String> kpiName = ihrService.getPopupName(params);
			
			modelMap.put("kpiName", kpiName);
			modelMap.put("result", "success");
		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}//popupNameAjax


	@RequestMapping(value = "/prfrmncUpdateAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	// ResponseBody : view로 인식, 돌려주는 결과가 view의 내용으로 인식됨.
	@ResponseBody
	public String prfrmncUpdateAjax(@RequestParam HashMap<String, String> params, ModelAndView modelAndView) throws Throwable {
		// ObjectMapper : jackson에서 제공. 객제정보를 문자열로 변환.(JSON형태)
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			int cnt = ihrService.prfrmncUpdate(params);
			
			if(cnt > 0) {
				modelMap.put("result", "success");
			} else {
				modelMap.put("result", "fail");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("result", "exception");
		}
		System.out.println(mapper.writeValueAsString(modelMap));
		// writeValueAsString : 값을 문자열로 변환(JSON형태)
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/slryCheck")
	  public ModelAndView slryCheck(ModelAndView mav) {
	  
	  mav.setViewName("hr/slryCheck");
	  
	  return mav;
	  
	  }
	 
	  @RequestMapping(value = "reloadInfoListAjax", method = RequestMethod.POST , produces = "text/json;charset=UTF-8" )
	  
	  @ResponseBody
	  public String reloadInfoListAjax(@RequestParam HashMap<String, String>params , HttpSession session ) throws Throwable {
	  
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String,Object> modelMap =new HashMap<String,Object>();
		
		try {
			params.put("emplyNo", String.valueOf(session.getAttribute("sEmplyNo")));
			List<HashMap<String,String>> list = ihrService.indEmplyList(params);
							
			modelMap.put("list",list);
			modelMap.put("result", "success");
			
			
		} catch (Throwable e) {
			e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
			modelMap.put("result","excepting");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	  @RequestMapping(value = "reloadIndPayListAjax", method = RequestMethod.POST , produces = "text/json;charset=UTF-8" )
	  
	  @ResponseBody
	  public String reloadIndPayListAjax(@RequestParam HashMap<String, String>params , HttpSession session ) throws Throwable {
	  
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String,Object> modelMap =new HashMap<String,Object>();
		
		try {
			params.put("emplyNo", String.valueOf(session.getAttribute("sEmplyNo")));
			List<HashMap<String,String>> list = ihrService.indPayList(params);
							
			modelMap.put("list",list);
			modelMap.put("result", "success");
			
			
		} catch (Throwable e) {
			e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
			modelMap.put("result","excepting");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	  
	  @RequestMapping(value = "reloadIndInsenListAjax", method = RequestMethod.POST , produces = "text/json;charset=UTF-8" )
	  
	  @ResponseBody
	  public String reloadIndInsenListAjax(@RequestParam HashMap<String, String>params , HttpSession session ) throws Throwable {
	  
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String,Object> modelMap =new HashMap<String,Object>();
		
		try {
			params.put("emplyNo", String.valueOf(session.getAttribute("sEmplyNo")));
			List<HashMap<String,String>> list = ihrService.indInsenList(params);
							
			modelMap.put("list",list);
			modelMap.put("result", "success");
			
			
		} catch (Throwable e) {
			e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
			modelMap.put("result","excepting");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	  @RequestMapping(value = "reloadIndTaxListAjax", method = RequestMethod.POST , produces = "text/json;charset=UTF-8" )
	  
	  @ResponseBody
	  public String reloadIndTaxListAjax(@RequestParam HashMap<String, String>params , HttpSession session ) throws Throwable {
	  
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String,Object> modelMap =new HashMap<String,Object>();
		
		try {
			params.put("emplyNo", String.valueOf(session.getAttribute("sEmplyNo")));
			List<HashMap<String,String>> list = ihrService.indTaxList(params);
							
			modelMap.put("list",list);
			modelMap.put("result", "success");
			
			
		} catch (Throwable e) {
			e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
			modelMap.put("result","excepting");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
   
	  @RequestMapping (value = "/prsnlSlryWrite")
	  public ModelAndView prsnlSlryWrite(HttpSession session, ModelAndView mav) {
				  
		  
		  mav.setViewName("hr/prsnlSlryWrite");
	  
		
	  
	  return mav;
	  
	  }
		@RequestMapping(value = "/reloadEmplyListAjax" , method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
		
		@ResponseBody // view로 인식, 결과가 view의 내용으로 인식되게 만들어줌
		public String reloadEmplyListAjax(@RequestParam HashMap<String,String>params)throws Throwable {
			
			//ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환(json의 형태)(자동변환이 안될경우 직접 json으로 만들어줘야한다)
			ObjectMapper mapper = new ObjectMapper();
			
			Map<String,Object> modelMap =new HashMap<String,Object>();
			
			try {
				
				List<HashMap<String,String>> list = ihrService.emplyList();
				
				modelMap.put("list",list);
				modelMap.put("result", "success");
				
				
			} catch (Throwable e) {
				e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
				modelMap.put("result","excepting");
			}
			
			return mapper.writeValueAsString(modelMap);
		}
	
	     

@RequestMapping(value = "slryStmnt")

public ModelAndView paypaper(ModelAndView mav) {

mav.setViewName("hr/slryStmnt");

return mav; }


@RequestMapping(value = "/yearIncm")
public ModelAndView yearIncm(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{


	  
mav.setViewName("/hr/yearIncm");
return mav;


}

@RequestMapping(value = "/IncmListAjax" , method = RequestMethod.POST,produces = "text/json;charset=UTF-8")

	@ResponseBody // view로 인식, 결과가 view의 내용으로 인식되게 만들어줌
	public String IncmListAjax(@RequestParam HashMap<String,String>params)throws Throwable {
		
		//ObjectMapper : jackson에서 제공. 객체정보를 문자열로 변환(json의 형태)(자동변환이 안될경우 직접 json으로 만들어줘야한다)
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String,Object> modelMap =new HashMap<String,Object>();
		
		try {
								
			List<HashMap<String,String>> list = ihrService.getincmList();
			
			modelMap.put("list",list);
			modelMap.put("result", "success");
			
			
		} catch (Throwable e) {
			e.printStackTrace();//예외내용을 콘솔로 찍어주는역할
			modelMap.put("result","excepting");
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	
}










