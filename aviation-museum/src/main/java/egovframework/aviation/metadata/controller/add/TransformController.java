package egovframework.aviation.metadata.controller.add;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.aviation.metadata.service.MetaDataService;
import egovframework.aviation.metadata.service.TransformService;
import egovframework.aviation.metadata.vo.OrgVO;
import egovframework.aviation.metadata.vo.PosSessionVO;
import egovframework.aviation.metadata.vo.metadata.TransformVO;
import egovframework.aviation.metadata.vo.param.TransformParamVO;
import egovframework.aviation.paging.Criteria;
import egovframework.aviation.paging.PageMaker;

@Controller
public class TransformController {
	
	@Autowired
	private MetaDataService service;
	
	@Autowired
	private TransformService service2;
	
	@GetMapping("/getTransform.do")
	public String getTransform(Model model) throws Exception {
		List<PosSessionVO> possession = service.getPosSession();
		List<OrgVO> org = service.getOrg();
		
		model.addAttribute("orgList", org);
		model.addAttribute("posSessionList", possession);
		
		return "metadata/management/transform/transform";
	}
	
	@PostMapping("/getTransformList.do")
	public String getTransformList(Model model, @ModelAttribute TransformParamVO param, @ModelAttribute Criteria cri) throws Exception {
		System.out.println(param);
		String result = "metadata/management/transform/transformList";
		
		if(param.getReg_state().equals("Y")) {
			result = "metadata/management/transform/transformYesList";
		} else if(param.getReg_state().equals("N")) {
			result = "metadata/management/transform/transformNotList";
		}
		
		int perPageNum = service2.getTransformListCnt(param);		
		if(param.getPerPageNum() != 0) {
			int criPerPageNum = param.getPerPageNum();
			cri.setPerPageNum(criPerPageNum);
		}
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(perPageNum);
		    
	    param.setPageStart(cri.getPageStart());
	    param.setPerPageNum(cri.getPerPageNum());
	    
		List<TransformVO> list = service2.getTransformList(param);
		
		if(list.size() == 0) {
			result = "metadata/management/transform/transformError";
		} else {
			model.addAttribute("transformList", list);
			model.addAttribute("perPageNum", perPageNum);
			model.addAttribute("pageMaker", pageMaker);
		}
		
		return result;
	}
	
	@PostMapping("/transformListExcel.do")
	public String transformListExcel(Model model, @ModelAttribute TransformParamVO param) throws Exception {
		System.out.println(param);
		String result = "metadata/management/transform/transformExcel";
		
		List<TransformVO> list = service2.getTransformAllList(param);
		
			model.addAttribute("transformList", list);
		
		return result;
	}
	
	@PostMapping("/changeTransformReg.do")
	public String changeTransformReg(Model model, @ModelAttribute TransformParamVO param) throws Exception {
		String result = "error";
		if(param.getReg_state().equals("N")) {
			param.setReg_state("Y");
		} else if(param.getReg_state().equals("Y")) {
			param.setReg_state("N");
		}
		int x = service2.changeTransformReg(param);
		if(x > 0) {
			result = "success";
			return result;
		} else {
			return result;
			
		}
	}
	
	@PostMapping("/changeTransformRegAll.do")
	public String changeTransformRegAll(Model model, @ModelAttribute TransformParamVO param) throws Exception {
		String result = "error";
		System.out.println(param);
		List<TransformVO> list = service2.getTransformAllList(param);
		List<String> list3 = new ArrayList<>();
		for(int i=0; i<list.size(); i++) {
			list3.add(list.get(i).getItem_idx());
		}
		
		param.setItem_idx(list3);
		
		if(param.getReg_state().equals("N")) {
			param.setReg_state("Y");
		} else if(param.getReg_state().equals("Y")) {
			param.setReg_state("N");
		}
		
		service2.changeTransformReg(param);
		
		return result;
	}
}
