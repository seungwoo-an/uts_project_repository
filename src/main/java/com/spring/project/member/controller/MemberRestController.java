package com.spring.project.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.project.common.PagingManager;
import com.spring.project.member.model.MemberVO;
import com.spring.project.member.model.SelectVO;
import com.spring.project.member.service.IMemberService;
import com.spring.project.product.model.OrdersVO;

@RestController
@RequestMapping("/member/rest")
public class MemberRestController {
	@Autowired
	IMemberService memberSerivce;
	@Autowired
	BCryptPasswordEncoder pwEncoder;

	@PostMapping("/memberCheck")
	public int memberCheck(@RequestParam("member_id") String member_id) {
		MemberVO member = memberSerivce.getMemberInfo(member_id);
		if (member == null)
			return 0;
		else
			return 1;
	}

	@PostMapping("/regNumCheck")
	public boolean regNumCheck(@RequestParam("seller_reg_num") String seller_reg_num) {
		return memberSerivce.getSellerRegNum(seller_reg_num);
	}

	@PostMapping("/checkemail")
	public int checkemail(Model model, @RequestParam(value = "member_email") String member_email) {
		if (memberSerivce.getMemberEmail(member_email) == null) {
			return 0;
		} else {
			return 1;
		}
	}

	@PostMapping("/list")
	public List<MemberVO> memberList(@RequestBody SelectVO select) {
		if (select.getSelect_auth() == null) {
			select.setSelect_auth("au.authority != ' '");
		} else {
			select.setSelect_auth("au.authority = '" + select.getSelect_auth() + "'");
		}

		if (select.getSelect_enabled() == null) {
			select.setSelect_enabled("m.member_enabled != ' '");
		} else {
			select.setSelect_enabled("m.member_enabled = '" + select.getSelect_enabled() + "'");
		}

		if (select.getSelect_word() == null) {
			if (select.getSelect_option() == null || select.getSelect_option() != null) {
				select.setSelect_word("(m.member_name != ' ' and m.member_tel != ' ' and m.member_email != ' ')");
			}
		} else {
			if (select.getSelect_option() == null) {
				select.setSelect_word("(m.member_name like '%" + select.getSelect_word() + "%' or m.member_tel like '%"
						+ select.getSelect_word() + "%' or m.member_email like '%" + select.getSelect_word() + "%')");
			} else {
				select.setSelect_word("m." + select.getSelect_option() + " like '%" + select.getSelect_word() + "%'");
			}
		}
		return memberSerivce.getMemberList(select.getPage(), select);

	}

	@RequestMapping(value = "/page_numbering", produces = "application/json;charset=UTF-8")
	public PagingManager page_Numbering(@RequestBody SelectVO select) {

		if (select.getSelect_auth() == null) {
			select.setSelect_auth("au.authority != ' '");
		} else {
			select.setSelect_auth("au.authority = '" + select.getSelect_auth() + "'");
		}

		if (select.getSelect_enabled() == null) {
			select.setSelect_enabled("m.member_enabled != ' '");
		} else {
			select.setSelect_enabled("m.member_enabled = '" + select.getSelect_enabled() + "'");
		}

		if (select.getSelect_word() == null) {
			if (select.getSelect_option() == null || select.getSelect_option() != null) {
				select.setSelect_word("(m.member_name != ' ' and m.member_tel != ' ' and m.member_email != ' ')");
			}
		} else {
			if (select.getSelect_option() == null) {
				select.setSelect_word("(m.member_name like '%" + select.getSelect_word() + "%' or m.member_tel like '%"
						+ select.getSelect_word() + "%' or m.member_email like '%" + select.getSelect_word() + "%')");
			} else {
				select.setSelect_word("m." + select.getSelect_option() + " like '%" + select.getSelect_word() + "%'");
			}
		}

		return new PagingManager(memberSerivce.getMemberCount(select), select.getPage());
	}

	@PostMapping("/choice_delete")
	public void choice_delete(@RequestBody String member_id) {
		memberSerivce.memberDelete(member_id);
	}

	@PostMapping(value = "/member_enable", produces = "application/json;charset=UTF-8")
	public void member_enable(@RequestBody MemberVO member) {
		if (member.getMember_enabled() == 0) {
			memberSerivce.member_enable(1, member.getMember_id());
		} else {
			memberSerivce.member_enable(0, member.getMember_id());
		}
	}

	@PostMapping("/password_test")
	public String password_test(@RequestBody MemberVO member) {
		String str = null;
		if (pwEncoder.matches(member.getMember_pw(), memberSerivce.getMemberPassword(member.getMember_id()))) {
			str = "true";
		} else {
			str = "false";
		}

		return str;
	}

	@PostMapping("/monthly_sales")
	public List<List<OrdersVO>> monthly_sales(Authentication authentication, @RequestBody int year) {
		return memberSerivce.getMonthlySales(authentication.getName(), year);
	}

	@PostMapping("/deleteSelectedMembers")
	public void deleteSelectedMembers(@RequestParam("member_ids[]") String[] member_ids) {
		memberSerivce.deleteSelectedMembers(member_ids);
	}

}
