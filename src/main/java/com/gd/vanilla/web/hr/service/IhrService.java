package com.gd.vanilla.web.hr.service;

import java.util.HashMap;
import java.util.List;

public interface IhrService {

	public int getEmpCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable;

	public void empWrite(HashMap<String, String> params) throws Throwable;

	public int getEmpEmailCheck(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getEmply(HashMap<String, String> params) throws Throwable;

	public int empUpdate(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getEmply2(HashMap<String, String> params) throws Throwable;

	public int getEmpEmailCheck2(HashMap<String, String> params) throws Throwable;

	public int getpdListcnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getpdList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getpd(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpListNp(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEmpListOp(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getAllEmply(HashMap<String, String> params) throws Throwable;

	public int forPdoWriteUpdateEmplyAdrs(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> onlyAdrs(HashMap<String, String> params) throws Throwable;

	public void pdWrite(HashMap<String, String> params)  throws Throwable;

	public HashMap<String, String> myinfologinCheck(HashMap<String, String> params) throws Throwable;

	public int psrdchange(HashMap<String, String> params) throws Throwable;

	public int pdUpdate(HashMap<String, String> params) throws Throwable;

	public void draftWrite(HashMap<String, String> params) throws Throwable;

	public int getDraftNo(HashMap<String, String> params) throws Throwable;

	public void signWrite(HashMap<String, String> params) throws Throwable;

	public int getdraftNoForUpdate(HashMap<String, String> params) throws Throwable;

	public int draftUpdate(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getPdNextvalNo(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getpdCondition(HashMap<String, String> params) throws Throwable;

	public int getbsclistcnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getbsclist(HashMap<String, String> params) throws Throwable;

	public int getStndrdBscNo(HashMap<String, String> params) throws Throwable;

	public void writeStndrdBscNo(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getBscStndYear(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getBscGbnDprtmnt(HashMap<String, String> params) throws Throwable;

	public void adtWrite(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> adtList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getChartAjax(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getPUList(HashMap<String, String> params) throws Throwable;

	public int adtUpdate(HashMap<String, String> params) throws Throwable;

	public int adtDelete(HashMap<String, String> params) throws Throwable;
	
	List<HashMap<String, String>> getChart()throws Throwable;

	public void groupwrite(HashMap<String, String> params)throws Throwable;

	public int groupupdateYn(HashMap<String, String> params)throws Throwable;

	public int getgroup(HashMap<String, String> params) throws Throwable;

	public int getempCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getempList(HashMap<String, String> params)throws Throwable;
	
	public int getdprtCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getdprtList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getPopEmplyData(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> MoveDprtList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> empsrchList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> prsnempList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> pstnsrchList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> vctnkindList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> empjnameList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> empbnameList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getListVctn(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getSpList(HashMap<String, String> params) throws Throwable;

	public void vctnadtWrite(HashMap<String, String> params) throws Throwable;

	public void signinsert(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getVctnKindList(HashMap<String, String> params) throws Throwable;

	public void vctnInsertWrite(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getindvdlvctnKindList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> useVctnList(HashMap<String, String> params)throws Throwable;

	public void csfWrite(HashMap<String, String> params) throws Throwable;

	public void vwpntWrite(HashMap<String, String> params) throws Throwable;

	public int getcsfCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getcsfList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getvwpntList(HashMap<String, String> params) throws Throwable;

	public String getvwpntName(HashMap<String, String> params) throws Throwable;

	public int csfdel(HashMap<String, Object> params) throws Throwable;

	public List<HashMap<String, String>> getkpicsfList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getcsfName(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getkpiList(HashMap<String, String> params) throws Throwable;

	public int getkpiCnt(HashMap<String, String> params) throws Throwable;

	public  HashMap<String, String> getKpinumber(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getIndctornumber(HashMap<String, String> params) throws Throwable;

	public void kpiWrite(HashMap<String, String> params) throws Throwable;

	public int kpidel(HashMap<String, Object> params) throws Throwable;

	public int getindctorCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getindctorList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getindctornumber(HashMap<String, String> params) throws Throwable;

	public void indctorWrite(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getkpiindctorList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getindctorName(HashMap<String, String> params) throws Throwable;

	public int getkpihdCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getkpihdList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getkpiIndcList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getkpiindctorName(HashMap<String, String> params) throws Throwable;

	public void goalWrite(HashMap<String, String> params) throws Throwable;

	public int getBscStdNo(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getBscnumber(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getPopupName(HashMap<String, String> params) throws Throwable;

	public int prfrmncUpdate(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getVwpntnumber(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getCsfnumber(HashMap<String, String> params) throws Throwable;

	public	List<HashMap<String, String>> emplyList()throws Throwable;

	public List<HashMap<String, String>> getincmList()throws Throwable;

	public List<HashMap<String, String>> indEmplyList (HashMap<String,String> params)throws Throwable;

	public List<HashMap<String, String>> indPayList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> indInsenList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> indTaxList(HashMap<String, String> params) throws Throwable;

}
