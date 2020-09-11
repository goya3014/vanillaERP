package com.gd.vanilla.web.hr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.vanilla.web.hr.dao.IhrDao;

@Service
public class hrService implements IhrService {
	@Autowired 
	public IhrDao ihrDao;

	@Override
	public int getEmpCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpList(params);
	}

	@Override
	public void empWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.empWrite(params);
	}

	@Override
	public int getEmpEmailCheck(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpEmailCheck(params);
	}

	@Override
	public HashMap<String, String> getEmply(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmply(params);
	}

	@Override
	public int empUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.empUpdate(params);
	}

	@Override
	public HashMap<String, String> getEmply2(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmply2(params);
	}

	@Override
	public int getEmpEmailCheck2(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpEmailCheck2(params);
	}

	@Override
	public int getpdListcnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getpdListcnt(params);
	}

	@Override
	public List<HashMap<String, String>> getpdList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getpdList(params);
	}

	@Override
	public HashMap<String, String> getpd(HashMap<String, String> params) throws Throwable {
		return ihrDao.getpd(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpListNp(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpListNp(params);
	}

	@Override
	public List<HashMap<String, String>> getEmpListOp(HashMap<String, String> params) throws Throwable {
		return ihrDao.getEmpListOp(params);
	}

	@Override
	public HashMap<String, String> getAllEmply(HashMap<String, String> params) throws Throwable {
		return ihrDao.getAllEmply(params);
	}

	@Override
	public int forPdoWriteUpdateEmplyAdrs(HashMap<String, String> params) throws Throwable {
		return ihrDao.forPdoWriteUpdateEmplyAdrs(params);
	}


	@Override
	public HashMap<String, String> onlyAdrs(HashMap<String, String> params) throws Throwable {
		return ihrDao.onlyAdrs(params);
	}

	@Override
	public void pdWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.pdWrite(params);
	}

	@Override
	public HashMap<String, String> myinfologinCheck(HashMap<String, String> params) throws Throwable {
		return ihrDao.myinfologinCheck(params);
	}

	@Override
	public int psrdchange(HashMap<String, String> params) throws Throwable {
		return ihrDao.psrdchange(params);
	}

	@Override
	public int pdUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.pdUpdate(params);
	}

	@Override
	public void draftWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.draftWrite(params);
		
	}

	@Override
	public int getDraftNo(HashMap<String, String> params) throws Throwable {
		return ihrDao.getDraftNo(params);
	}

	@Override
	public void signWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.signWrite(params);
	}

	@Override
	public int getdraftNoForUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.getdraftNoForUpdate(params);
	}

	@Override
	public int draftUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.draftUpdate(params);
	}

	@Override
	public HashMap<String, String> getPdNextvalNo(HashMap<String, String> params) throws Throwable {
		return ihrDao.getPdNextvalNo(params);
	}

	@Override
	public HashMap<String, String> getpdCondition(HashMap<String, String> params) throws Throwable {
		return ihrDao.getpdCondition(params);
	}

	@Override
	public int getbsclistcnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getbsclistcnt(params);
	}

	@Override
	public List<HashMap<String, String>> getbsclist(HashMap<String, String> params) throws Throwable {
		return ihrDao.getbsclist(params);
	}

	@Override
	public int getStndrdBscNo(HashMap<String, String> params) throws Throwable {
		return ihrDao.getStndrdBscNo(params);
	}

	@Override
	public void writeStndrdBscNo(HashMap<String, String> params) throws Throwable {
		ihrDao.writeStndrdBscNo(params);
		
	}

	@Override
	public List<HashMap<String, String>> getBscStndYear(HashMap<String, String> params) throws Throwable {
		return ihrDao.getBscStndYear(params);
	}

	@Override
	public List<HashMap<String, String>> getBscGbnDprtmnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getBscGbnDprtmnt(params);
	}

	@Override
	public void adtWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.adtWrite(params);
	}

	@Override
	public List<HashMap<String, String>> adtList(HashMap<String, String> params) throws Throwable {
		return ihrDao.adtList(params);
	}

	@Override
	public List<HashMap<String, String>> getChartAjax(HashMap<String, String> params) throws Throwable {
		return ihrDao.getChartAjax(params);
	}

	@Override
	public List<HashMap<String, String>> getPUList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getPUList(params);
	}

	@Override
	public int adtUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.adtUpdate(params);
	}

	@Override
	public int adtDelete(HashMap<String, String> params) throws Throwable {
		return ihrDao.adtDelete(params);
	}
	
	@Override
	public List<HashMap<String, String>> getChart() throws Throwable {
		return ihrDao.getChart();
	}

	@Override
	public void groupwrite(HashMap<String, String> params) throws Throwable {
		ihrDao.groupwrite(params);
	}

	@Override
	public int groupupdateYn(HashMap<String, String> params) throws Throwable {
		return ihrDao.groupupdateYn(params);
	}

	@Override
	public int getgroup(HashMap<String, String> params) throws Throwable {
		return ihrDao.getgroup(params);
	}

	@Override
	public int getempCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getempCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getempList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getempList(params);
	}
	
	@Override
	public int getdprtCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getdprtCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getdprtList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getdprtList(params);
	}

	@Override
	public HashMap<String, String> getPopEmplyData(HashMap<String, String> params) throws Throwable {
		return ihrDao.getPopEmplyData(params);
	}

	@Override
	public List<HashMap<String, String>> MoveDprtList(HashMap<String, String> params) throws Throwable {
		return ihrDao.MoveDprtList(params);
	}

	@Override
	public List<HashMap<String, String>> empsrchList(HashMap<String, String> params) throws Throwable {
		return ihrDao.empsrchList(params);
	}

	@Override
	public HashMap<String, String> prsnempList(HashMap<String, String> params) throws Throwable {
		return ihrDao.prsnempList(params);
	}

	@Override
	public List<HashMap<String, String>> pstnsrchList(HashMap<String, String> params) throws Throwable {
		return ihrDao.pstnsrchList(params);
	}

	@Override
	public List<HashMap<String, String>> vctnkindList(HashMap<String, String> params) throws Throwable {
		return ihrDao.vctnkindList(params);
	}

	@Override
	public List<HashMap<String, String>> empjnameList(HashMap<String, String> params) throws Throwable {
		return ihrDao.empjnameList(params);
	}

	@Override
	public List<HashMap<String, String>> empbnameList(HashMap<String, String> params) throws Throwable {
		return ihrDao.empbnameList(params);
	}

	@Override
	public List<HashMap<String, String>> getListVctn(HashMap<String, String> params) throws Throwable {
		return ihrDao.getListVctn(params);
	}

	@Override
	public List<HashMap<String, String>> getSpList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getSpList(params);
	}

	@Override
	public void vctnadtWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.vctnadtWrite(params);
	}

	@Override
	public void signinsert(HashMap<String, String> params) throws Throwable {
		ihrDao.signinsert(params);
	}

	@Override
	public List<HashMap<String, String>> getVctnKindList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getVctnKindList(params);
	}

	@Override
	public void vctnInsertWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.vctnInsertWrite(params);
	}

	@Override
	public List<HashMap<String, String>> getindvdlvctnKindList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getindvdlvctnKindList(params);
	}

	@Override
	public List<HashMap<String, String>> useVctnList(HashMap<String, String> params) throws Throwable {
		return ihrDao.useVctnList(params);
	}
	
	@Override
	public void csfWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.csfWrite(params);
		
	}

	@Override
	public void vwpntWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.vwpntWrite(params);
		
	}

	@Override
	public int getcsfCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getcsfCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getcsfList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getcsfList(params);
	}

	@Override
	public List<HashMap<String, String>> getvwpntList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getvwpntList(params);
	}
	
	@Override
	public HashMap<String, String> getVwpntnumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getVwpntnumber(params);
	}

	@Override
	public HashMap<String, String> getCsfnumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getCsfnumber(params);
	}


	@Override
	public String getvwpntName(HashMap<String, String> params) throws Throwable {
		return ihrDao.getvwpntName(params);
	}

	@Override
	public int csfdel(HashMap<String, Object> params) throws Throwable {
		return ihrDao.csfdel(params);
	}

	@Override
	public List<HashMap<String, String>> getkpicsfList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpicsfList(params);
	}

	@Override
	public HashMap<String, String> getcsfName(HashMap<String, String> params) throws Throwable {
		return ihrDao.getcsfName(params);
	}

	@Override
	public List<HashMap<String, String>> getkpiList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpiList(params);
	}

	@Override
	public int getkpiCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpiCnt(params);
	}

	@Override
	public HashMap<String, String> getKpinumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getKpinumber(params);
	}

	@Override
	public HashMap<String, String> getIndctornumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getIndctornumber(params);
	}

	@Override
	public void kpiWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.kpiWrite(params);
		
	}

	@Override
	public int kpidel(HashMap<String, Object> params) throws Throwable {
		return ihrDao.kpidel(params);
	}

	@Override
	public int getindctorCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getindctorCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getindctorList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getindctorList(params);
	}

	@Override
	public HashMap<String, String> getindctornumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getindctornumber(params);
	}

	@Override
	public void indctorWrite(HashMap<String, String> params) throws Throwable {
			ihrDao.indctorWrite(params);
		
	}

	@Override
	public List<HashMap<String, String>> getkpiindctorList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpiindctorList(params);
	}

	@Override
	public HashMap<String, String> getindctorName(HashMap<String, String> params) throws Throwable {
		return ihrDao.getindctorName(params);
	}

	@Override
	public int getkpihdCnt(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpihdCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getkpihdList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpihdList(params);
	}

	@Override
	public List<HashMap<String, String>> getkpiIndcList(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpiIndcList(params);
	}

	@Override
	public HashMap<String, String> getkpiindctorName(HashMap<String, String> params) throws Throwable {
		return ihrDao.getkpiindctorName(params);
	}

	@Override
	public void goalWrite(HashMap<String, String> params) throws Throwable {
		ihrDao.goalWrite(params);
		
	}

	@Override
	public int getBscStdNo(HashMap<String, String> params) throws Throwable {
		return ihrDao.getBscStdNo(params);
	}

	@Override
	public HashMap<String, String> getBscnumber(HashMap<String, String> params) throws Throwable {
		return ihrDao.getBscnumber(params);
	}

	@Override
	public HashMap<String, String> getPopupName(HashMap<String, String> params) throws Throwable {
		return ihrDao.getPopupName(params);
	}

	@Override
	public int prfrmncUpdate(HashMap<String, String> params) throws Throwable {
		return ihrDao.prfrmncUpdate(params);
	}
	
	@Override
	public List<HashMap<String, String>> emplyList()throws Throwable {
		return ihrDao.emplyList();
	}

	@Override
	public List<HashMap<String, String>> getincmList() throws Throwable {
		return ihrDao.getincmList();
	}

	@Override
	public List<HashMap<String, String>> indEmplyList(HashMap<String,String> params) throws Throwable {
		return ihrDao.indEmplyList(params);
	}

	@Override
	public List<HashMap<String, String>> indPayList(HashMap<String, String> params) throws Throwable {
		return ihrDao.indPayList(params);
	}

	@Override
	public List<HashMap<String, String>> indInsenList(HashMap<String, String> params) throws Throwable {
		return ihrDao.indInsenList(params);
	}

	@Override
	public List<HashMap<String, String>> indTaxList(HashMap<String, String> params) throws Throwable {
		return ihrDao.indTaxList(params);
	}




}
