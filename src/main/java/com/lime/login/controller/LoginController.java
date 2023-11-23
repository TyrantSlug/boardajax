package com.lime.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.lime.common.service.CommonService;
import com.lime.login.service.LoginService;
import com.lime.user.vo.UserVO;
import com.lime.util.CommUtils;


@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;
	

	@Resource(name = "jsonView")
	private MappingJackson2JsonView jsonView;

	@Resource(name="commonService")
	private CommonService commonService;

	@RequestMapping(value="/login/login.do")
	public String loginview(HttpServletRequest request ) {

		return "/login/login";
	}
	
	@RequestMapping(value="/login/naverCallback.do")
	public String naverCallback(HttpServletRequest request ) {

		return "/login/naverCallback";
	}

	@RequestMapping(value = "/login/login2.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> login2(@RequestBody Map<String, Object> user, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
        	System.out.println(user);
            boolean isValid = loginService.login(user);
            if(isValid) {
                session.setAttribute("user", user.get("userId"));
                result.put("result", "success");
              //  session.setAttribute("loginType", "regular");
                System.out.println(session.getAttribute("user"));
            } else {
                result.put("result", "fail");
                result.put("message", "로그인 정보가 잘못되었습니다.");
            }
        } catch (Exception e) {
            result.put("result", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }
	


	@RequestMapping(value = "/login/setNicknameInSession.do", method = RequestMethod.POST)
	public ResponseEntity<String> setNicknameInSession(HttpServletRequest request, @RequestParam String nickname) {
	    // nickname 값의 유효성 체크
	    if(nickname == null || nickname.trim().isEmpty()) {
	        return new ResponseEntity<String>("invalid_nickname", HttpStatus.BAD_REQUEST);
	    }

	    HttpSession session = request.getSession();
	    try {
	        session.setAttribute("user", nickname); // 닉네임 세션에 저장
	        session.setAttribute("loginType", "social"); // 로그인 타입을 "social"로 설정
	        System.out.println(session.getAttribute("user"));
	        return new ResponseEntity<String>("success", HttpStatus.OK);
	    } catch(Exception e) {
	        System.err.println("Error in setNicknameInSession: " + e.getMessage()); // 추가적인 에러 로그
	        return new ResponseEntity<String>("failed", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	

	@RequestMapping(value="/login/logout.do", method = RequestMethod.POST)
	public ResponseEntity<?> logout(HttpServletRequest request, HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		session.removeAttribute("user");
		session.removeAttribute("loginType");
		map.put("result", "success");
		System.out.println(session.getAttribute("user"));
		return ResponseEntity.ok(map);
	}
	

}// end of class
