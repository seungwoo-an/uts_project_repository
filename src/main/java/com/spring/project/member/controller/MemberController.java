package com.spring.project.member.controller;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.project.member.model.MemberVO;
import com.spring.project.member.model.SellerInfoVO;
import com.spring.project.member.service.IMemberService;
import com.spring.project.product.service.OrderService;
import com.spring.project.product.service.ProductService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	IMemberService memberSerivce;
	@Autowired
	BCryptPasswordEncoder pwEncoder;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	ProductService productService;
	@Autowired
	OrderService orderService;

	@GetMapping("/form")
	public void form(Model model) {
		model.addAttribute("message", "insert");
	}

	@PostMapping("/checkpwd")
	public String checkemail(MemberVO membervo, Model model) {
		if (pwEncoder.matches(membervo.getMember_pw(), memberSerivce.getMemberPassword(membervo.getMember_id()))) { // 1번째
																													// 방법
			String userId = membervo.getMember_id();
			return "redirect:/member/form/" + userId;
		} else {
			model.addAttribute("message", "nomatchpw");
			return "redirect:/member/info";
		}
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/form/{userId}")
	public String form(@PathVariable("userId") String userId, Model model) {
		model.addAttribute("member", memberSerivce.getMemberInfo(userId));
		model.addAttribute("message", "update");
		return "member/form";
	}

	@PostMapping("/insert")
	public String insertMember(MemberVO member, RedirectAttributes redirectAttributes,
			@RequestParam(value = "seller_reg_num", required = false) String seller_reg_num) {
		member.setMember_pw(pwEncoder.encode(member.getPassword()));
		if (member.getMember_auth().equals("ROLE_CUSTOMER"))
			member.setMember_enabled(1);
		memberSerivce.memberInsert(member);
		if (!seller_reg_num.equals("")) {
			memberSerivce.insertSellerRegNum(member.getMember_id(), seller_reg_num);
			redirectAttributes.addAttribute("userId", member.getMember_id());
			return "redirect:/member/sellerinfoform";
		}
		return "redirect:/";
	}

	@GetMapping("/sellerinfoform")
	public void sellerInfoForm(@RequestParam("userId") String userId, Model model) {
		model.addAttribute("sellerInfo", memberSerivce.getSellerInfo(userId));
	}

	@PostMapping("/sellerinfoupdate")
	public String sellerInfoUpdate(SellerInfoVO sellerInfo) {
		memberSerivce.updateSellerInfo(sellerInfo);
		return "redirect:/";
	}

	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@RequestMapping("/list")
	public void getMemberList() {
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/info")
	public String getMember(Authentication authentication, Model model,
			@RequestParam(value = "member_id", required = false, defaultValue = "user") String member_id) {
		MemberVO member = memberSerivce.getMemberInfo(authentication.getName());
		model.addAttribute("member", member);
		if (member.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_SELLER"))) {
			model.addAttribute("sellerInfo", memberSerivce.getSellerInfo(authentication.getName()));
			model.addAttribute("totalCount", productService.getTotalCount(authentication.getName())); // 상품 총 등록 갯수
			model.addAttribute("productList", productService.getSellerProductList(authentication.getName()));
			model.addAttribute("sellerOrdersList", orderService.getSellerAdminOrderList(authentication.getName()));
		}

		if (!member_id.equals("user")) {
			model.addAttribute("orderLists", orderService.getOrderList(member_id));
		} else {
			model.addAttribute("orderLists", orderService.getOrderList(authentication.getName()));
		}
		return "member/info";
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/update")
	public String update(MemberVO member) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		member.setMember_pw(pwEncoder.encode(member.getMember_pw()));
		memberSerivce.updateMember(member);
		if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_MASTER"))) {
			return "redirect:/member/list";
		}
		return "redirect:/member/info";
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/changepwd")
	public String changePwd(MemberVO memberVO, RedirectAttributes redirectAttributes) {
		memberSerivce.changePwd(pwEncoder.encode(memberVO.getMember_pw()), memberVO.getMember_id());
		redirectAttributes.addAttribute("message", "update");
		return "redirect:/login";
	}

	@PreAuthorize("isAnonymous()")
	@RequestMapping("/findidpwd")
	public void findidpwd(Model model, @RequestParam("choice") String choice,
			@RequestParam(value = "message", required = false) String message) {
		model.addAttribute("chocie", choice);
		model.addAttribute("message", message);
	}

	@PostMapping("/certification")
	public String certification(Model model, @RequestParam(value = "choice") String choice, MemberVO memberVO,
			RedirectAttributes redirectAttributes) {
		if (memberVO.getMember_email() == null) {
			redirectAttributes.addAttribute("message", "nonemessage");
			redirectAttributes.addAttribute("choice", choice);
			return "redirect:/member/findidpwd";
		} else if (memberSerivce.getMemberEmail(memberVO.getMember_email()) == null) {
			redirectAttributes.addAttribute("message", "reloadpage");
			redirectAttributes.addAttribute("choice", choice);
			return "redirect:/member/findidpwd";
		}
		model.addAttribute("findInfo", memberVO);
		model.addAttribute("choice", choice);
		return "/member/certification";
	}

	@PostMapping("/findsendemail")
	public void findsendemail(MemberVO memberVO, Model model, @RequestParam(value = "choice") String choice) {
		String setfrom = "underthesea5@naver.com";
		String tomail = memberVO.getMember_email();
		String title = memberVO.getMember_name() + "님" + "UTS-5 [Under The Sea 5] 인증번호 메일입니다.";
		int num = ((int) (Math.random() * 10000) + 1000);
		String content = "인증번호 : [ " + Integer.toString(num) + " ]";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		model.addAttribute("member", memberVO);
		model.addAttribute("choice", choice);
		model.addAttribute("number", num);
	}

	@PostMapping("/lastfindidpwd")
	public String lastfindidpwd(MemberVO memberVO, Model model, @RequestParam(value = "choice") String choice) {
		model.addAttribute("choice", choice);
		model.addAttribute("member", memberSerivce.getMemberEmail(memberVO.getMember_email()).getMember_id());
		return "/member/lastfindidpwd";
	}

}
