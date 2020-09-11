package com.gd.vanilla.web.hr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class hrDao implements IhrDao {
	@Autowired 
	public SqlSession SqlSession;

	@Override
	public int getEmpCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getEmpCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getEmpList",params);
	}

	@Override
	public void empWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.empWrite",params);
	}

	@Override
	public int getEmpEmailCheck(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getEmpEmailCheck",params);
	}

	@Override
	public HashMap<String, String> getEmply(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getEmply",params);
	}

	@Override
	public int empUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.empUpdate",params);
	}

	@Override
	public HashMap<String, String> getEmply2(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getEmply2",params);
	}

	@Override
	public int getEmpEmailCheck2(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getEmpEmailCheck2",params);
	}

	@Override
	public int getpdListcnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getpdListcnt",params);
	}

	@Override
	public List<HashMap<String, String>> getpdList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getpdList",params);
	}

	@Override
	public HashMap<String, String> getpd(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getpd",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpListNp(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getEmpListNp",params);
	}

	@Override
	public List<HashMap<String, String>> getEmpListOp(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getEmpListOp",params);
	}

	@Override
	public HashMap<String, String> getAllEmply(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getAllEmply",params);
	}

	@Override
	public int forPdoWriteUpdateEmplyAdrs(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.forPdoWriteUpdateEmplyAdrs",params);
	}

	@Override
	public HashMap<String, String> onlyAdrs(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.onlyAdrs",params);
	}

	@Override
	public void pdWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.pdWrite",params);
		
	}

	@Override
	public HashMap<String, String> myinfologinCheck(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.myinfologinCheck",params);
	}

	@Override
	public int psrdchange(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.psrdchange",params);
	}

	@Override
	public int pdUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.pdUpdate",params);
	}

	@Override
	public void draftWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.draftWrite",params);
		
	}

	@Override
	public int getDraftNo(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getDraftNo",params);
	}

	@Override
	public void signWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.signWrite",params);
		
	}

	@Override
	public int getdraftNoForUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getdraftNoForUpdate",params);
	}

	@Override
	public int draftUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.draftUpdate",params);
	}

	@Override
	public HashMap<String, String> getPdNextvalNo(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getPdNextvalNo",params);
	}

	@Override
	public HashMap<String, String> getpdCondition(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getpdCondition",params);
	}

	@Override
	public int getbsclistcnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getbsclistcnt",params);
	}

	@Override
	public List<HashMap<String, String>> getbsclist(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getbsclist",params);
	}

	@Override
	public int getStndrdBscNo(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getStndrdBscNo",params);
	}

	@Override
	public void writeStndrdBscNo(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.writeStndrdBscNo",params);
		
	}

	@Override
	public List<HashMap<String, String>> getBscStndYear(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getBscStndYear",params);
	}

	@Override
	public List<HashMap<String, String>> getBscGbnDprtmnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getBscGbnDprtmnt",params);
	}

	@Override
	public void adtWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.adtWrite", params);
	}

	@Override
	public List<HashMap<String, String>> adtList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.adtList", params);
	}

	@Override
	public List<HashMap<String, String>> getChartAjax(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return SqlSession.selectList("hr.getChartAjax", params);
	}

	@Override
	public List<HashMap<String, String>> getPUList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getPUList", params);
	}

	@Override
	public int adtUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.adtUpdate", params);
	}

	@Override
	public int adtDelete(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.adtDelete", params);
	}

	@Override
	public List<HashMap<String, String>> getChart() throws Throwable {
		return SqlSession.selectList("hr.getchart");
	}

	@Override
	public void groupwrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.groupwrite",params);
	}

	@Override
	public int groupupdateYn(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.groupupdateYn", params);
	}

	@Override
	public int getgroup(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getgroup", params);
	}

	@Override
	public int getempCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getempCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getempList(HashMap<String, String> params) throws Throwable {
		return  SqlSession.selectList("hr.getempList", params);
	}
	
	@Override
	public int getdprtCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getdprtCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getdprtList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getdprtList", params);
	}

	@Override
	public HashMap<String, String> getPopEmplyData(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getPopEmplyData", params);
	}

	@Override
	public List<HashMap<String, String>> MoveDprtList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.MoveDprtList", params);
	}

	@Override
	public List<HashMap<String, String>> empsrchList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.empsrchList", params);
	}

	@Override
	public HashMap<String, String> prsnempList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.prsnempList", params);
	}

	@Override
	public List<HashMap<String, String>> pstnsrchList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.pstnsrchList", params);
	}

	@Override
	public List<HashMap<String, String>> vctnkindList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.vctnkindList", params);
	}

	@Override
	public List<HashMap<String, String>> empjnameList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.empjnameList", params);

	}

	@Override
	public List<HashMap<String, String>> empbnameList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.empbnameList", params);
	}

	@Override
	public List<HashMap<String, String>> getListVctn(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getListVctn", params);
	}

	@Override
	public List<HashMap<String, String>> getSpList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getSpList", params);
	}

	@Override
	public void vctnadtWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.vctnadtWrite", params);

	}

	@Override
	public void signinsert(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.signinsert",params);
	}

	@Override
	public List<HashMap<String, String>> getVctnKindList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getVctnKindList", params);
	}

	@Override
	public void vctnInsertWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.vctnInsertWrite",params);

	}

	@Override
	public List<HashMap<String, String>> getindvdlvctnKindList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getindvdlvctnKindList", params);
	}

	@Override
	public List<HashMap<String, String>> useVctnList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.useVctnList", params);
	}
	
	@Override
	public void csfWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.csfWrite",params);
		
	}

	@Override
	public void vwpntWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.vwpntWrite",params);
		
	}

	@Override
	public int getcsfCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getcsfCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getcsfList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getcsfList",params);
	}

	@Override
	public List<HashMap<String, String>> getvwpntList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getvwpntList",params);
	}


	@Override
	public String getvwpntName(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getvwpntName",params);
	}

	@Override
	public int csfdel(HashMap<String, Object> params) throws Throwable {
		return SqlSession.update("hr.csfdel",params);
	}

	@Override
	public List<HashMap<String, String>> getkpicsfList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getkpicsfList",params);
	}

	@Override
	public HashMap<String, String> getcsfName(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getcsfName",params);
	}

	@Override
	public List<HashMap<String, String>> getkpiList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getkpiList",params);
	}

	@Override
	public int getkpiCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getkpiCnt",params);
	}

	@Override
	public HashMap<String, String> getKpinumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getKpinumber",params);
	}

	@Override
	public HashMap<String, String> getIndctornumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getIndctornumber",params);
	}

	@Override
	public void kpiWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.kpiWrite",params);
		
	}

	@Override
	public int kpidel(HashMap<String, Object> params) throws Throwable {
		return SqlSession.update("hr.kpidel",params);
	}

	@Override
	public int getindctorCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getindctorCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getindctorList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getindctorList",params);
	}

	@Override
	public HashMap<String, String> getindctornumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getindctornumber",params);
	}

	@Override
	public void indctorWrite(HashMap<String, String> params) throws Throwable {
		 SqlSession.insert("hr.indctorWrite",params);
		
	}

	@Override
	public List<HashMap<String, String>> getkpiindctorList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getkpiindctorList",params);
	}

	@Override
	public HashMap<String, String> getindctorName(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getindctorName",params);
	}

	@Override
	public int getkpihdCnt(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getkpihdCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getkpihdList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getkpihdList",params);
	}

	@Override
	public List<HashMap<String, String>> getkpiIndcList(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectList("hr.getkpiIndcList",params);
	}

	@Override
	public HashMap<String, String> getkpiindctorName(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getkpiindctorName",params);
	}

	@Override
	public void goalWrite(HashMap<String, String> params) throws Throwable {
		SqlSession.insert("hr.goalWrite",params);
		
	}

	@Override
	public int getBscStdNo(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getBscStdNo",params);
	}

	@Override
	public HashMap<String, String> getBscnumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getBscnumber",params);
	}

	@Override
	public HashMap<String, String> getPopupName(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getPopupName",params);
	}

	@Override
	public int prfrmncUpdate(HashMap<String, String> params) throws Throwable {
		return SqlSession.update("hr.prfrmncUpdate",params);
	}

	@Override
	public HashMap<String, String> getVwpntnumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getVwpntnumber",params);
	}

	@Override
	public HashMap<String, String> getCsfnumber(HashMap<String, String> params) throws Throwable {
		return SqlSession.selectOne("hr.getCsfnumber",params);
	}
	
	@Override
	public List<HashMap<String, String>> emplyList() throws Throwable {

		return SqlSession.selectList("hr.emplyList");
	}


	@Override
	public List<HashMap<String, String>> getincmList() throws Throwable {
		// TODO Auto-generated method stub
		return SqlSession.selectList("hr.getincmList");
	}


	@Override
	public List<HashMap<String, String>> indEmplyList(HashMap<String,String> params) throws Throwable {

		return SqlSession.selectList("hr.indEmplyList", params);
	}


	@Override
	public List<HashMap<String, String>> indPayList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return SqlSession.selectList("hr.indPayList",params);
	}


	@Override
	public List<HashMap<String, String>> indInsenList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return SqlSession.selectList("hr.indInsenList",params);
	}


	@Override
	public List<HashMap<String, String>> indTaxList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return SqlSession.selectList("hr.indTaxList",params);
	}



}
