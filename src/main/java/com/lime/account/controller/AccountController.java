package com.lime.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.lime.account.service.AccountService;
import com.lime.account.vo.AccountVO;
import com.lime.common.service.CommonService;
import com.lime.util.CommUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AccountController {


	@Resource(name = "jsonView")
	private MappingJackson2JsonView jsonView;

	@Resource(name="accountService")
	private AccountService accountService;

	@Resource(name="commonService")
	private CommonService commonService;

	/**
	 *
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/account/accountList.do")
	public String selectSampleList(HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> inOutMap  = CommUtils.getFormParam(request);


		model.put("inOutMap", inOutMap);
		return "/account/accountList";
	}

	
	@RequestMapping(value = "/account/accountList2.do", method = RequestMethod.GET)
	public ResponseEntity<?> getAccountList(@RequestParam("pageNo") int pageNo) {
        Map<String, Object> map = new HashMap<>();

        try {
            PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(pageNo);
            paginationInfo.setRecordCountPerPage(10);
            paginationInfo.setPageSize(10);

            int firstRecordIndex = paginationInfo.getFirstRecordIndex();
            int recordCountPerPage = paginationInfo.getRecordCountPerPage();
            map.put("firstIndex", firstRecordIndex);
            map.put("recordCountPerPage", recordCountPerPage);

            int totalCount = accountService.getTotalCount();
            paginationInfo.setTotalRecordCount(totalCount);

            List<AccountVO> accounts = accountService.findAll(map);

            map.put("result", "success");
            map.put("data", accounts);
            map.put("paginationInfo", paginationInfo);
            
            return ResponseEntity.ok(map);
   //         return (ResponseEntity<?>) accounts;
        } catch (Exception e) {
            map.clear();
            map.put("result", "fail");
            map.put("message", e.getMessage());
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
        }
    }


	@RequestMapping("/account/excelDownload.do")
    public void excelDownload(HttpServletResponse response) throws Exception {

        List<AccountVO> list = accountService.findAllList();

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Account Data");
        
        Row headerRow = sheet.createRow(0);
        String[] headers = {"수익/비용", "관", "항", "목", "과", "금액", "등록일", "작성자"};
        for (int col = 0; col < headers.length; col++) {
            Cell cell = headerRow.createCell(col);
            cell.setCellValue(headers[col]);
        }

        for (int rowNum = 1; rowNum <= list.size(); rowNum++) {
            AccountVO account = list.get(rowNum - 1);
            Row row = sheet.createRow(rowNum);

            row.createCell(0).setCellValue(account.getProfitCost());
            row.createCell(1).setCellValue(account.getBigGroup());
            row.createCell(2).setCellValue(account.getMiddleGroup());
            row.createCell(3).setCellValue(account.getSmallGroup());
            row.createCell(4).setCellValue(account.getDetailGroup());
            row.createCell(5).setCellValue(account.getTransactionMoney());
            row.createCell(6).setCellValue(account.getTransactionDate());
            row.createCell(7).setCellValue(account.getWriter());
        }

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=account_data.xlsx");
        
        workbook.write(response.getOutputStream());
        workbook.close();
    }


	/**
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/account/accountInsert.do")
	public String accountInsert(HttpServletRequest request, ModelMap model) throws Exception{

		Map<String, Object> inOutMap = new HashMap<>();


		inOutMap.put("category", "A000000");
		List<EgovMap> resultMap= commonService.selectCombo(inOutMap);

		System.out.println(resultMap);
		model.put("resultMap", resultMap);

		return "/account/accountInsert";
	}
	
	
	@RequestMapping(value="/account/selectCombo.do", method = RequestMethod.POST)
	@ResponseBody
	public List<EgovMap> selectCombo(@RequestParam String dropdownType, @RequestParam String code) throws Exception {
	    Map<String, Object> inOutMap = new HashMap<>();
	    inOutMap.put("category", code);

	    return commonService.selectCombo(inOutMap);
	}



	@RequestMapping(value = "/account/insertAccount.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> insertAccount(@RequestBody AccountVO accountVO) {
	    Map<String, Object> map = new HashMap<>();
	    try {
	        int accountSeq = accountService.insertAccount(accountVO);
	        map.put("result", "success");
	        map.put("accountSeq", accountSeq);
	        System.out.println(accountSeq);
	    } catch (Exception e) {
	    	map.put("result", "fail");
	    	System.out.println(e.getMessage());
	    }
	    return ResponseEntity.ok(map);
	}

	
	@RequestMapping(value = "/account/updateAccount.do", method = RequestMethod.PUT)
	@ResponseBody
	public ResponseEntity<?> updateAccount(@RequestBody AccountVO accountVO) {
	    Map<String, Object> map = new HashMap<>();
	    try {
	        accountService.updateAccount(accountVO);
	        map.put("result", "success");
	    } catch (Exception e) {
	    	map.put("result", "fail");
	    	System.out.println(e.getMessage());
	    }
	    return ResponseEntity.ok(map);
	}
	

	
	@RequestMapping(value="/account/accountUpdate.do")
	public String accountUpdate(HttpServletRequest request, ModelMap model) throws Exception{

		Map<String, Object> inOutMap = new HashMap<>();


		inOutMap.put("category", "A000000");
		List<EgovMap> resultMap= commonService.selectCombo(inOutMap);

		System.out.println(resultMap);
		model.put("resultMap", resultMap);

		return "/account/accountUpdate";
	}
	
	@RequestMapping(value="/account/selectCombo2.do", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> selectCombo2(@RequestParam("id") int id) throws Exception {
	    Map<String, Object> map = new HashMap<>();

	    try {
	    	AccountVO accountVO = accountService.getAccountById(id);
	    	map.put("result", "success");
	    	map.put("data", accountVO);
	    	
	    } catch (Exception e) {
	    	map.put("result", "fail");
	    	System.out.println(e.getMessage());
	    }
	    return ResponseEntity.ok(map);
	}


}// end of calss
