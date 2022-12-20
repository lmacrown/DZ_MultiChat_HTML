package Member;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberAction {
	public JSONObject loginCheck(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("logincheck 시작");
		JSONObject jsonResult = new JSONObject();
		MemberDAO memberDAO = new MemberDAO();
		
		request.setCharacterEncoding("UTF-8");
		System.out.println("write in");
		// 저장소 객체 생성  
		DiskFileItemFactory factory = new DiskFileItemFactory();

		//업로드 파일 임시로 저장할 경로 설정 
		factory.setRepository(new File("c:\\upload"));

		// 파일 업로드 객체에 저장소 설정 
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		Map<String, List<FileItem>> mapItems = upload.parseParameterMap(request);
		
		String id = mapItems.get("uid").get(0).getString();
		String pw = mapItems.get("pwd").get(0).getString();
		System.out.println("id :"+id+", pwd : "+pw);
		String checking = memberDAO.checkMember(id, pw);
		if (checking.equals("admin"))
			jsonResult.put("url", "/multichat/jsp/adminPage.jsp");
		if (checking.equals("valid")) {
			request.getSession().setAttribute("uid", id);
			System.out.println("로그인 성공");
			jsonResult.put("status", true);
			jsonResult.put("url", "/DZ_MultiChat/home.jsp");
		} else if (checking.equals("not_match")) {
			System.out.println("로그인 실패");
			jsonResult.put("status", false);
		} else if (checking.equals("invalid")) {
			System.out.println("휴면");
			jsonResult.put("status", "invalid");
		}
		return jsonResult;
	}
	// 중복확인
	public JSONObject dupUidCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uid = request.getParameter("uid");
		System.out.println("중복체크");
		MemberDAO memberDAO = new MemberDAO();
		MemberBean memberBean = memberDAO.viewMember(uid);
		JSONObject jsonResult = new JSONObject();

		if (memberBean == null) {
			System.out.println("중복없음");
			jsonResult.put("status", true);
			jsonResult.put("message", "해당 아이디는 사용가능합니다");
		} else {
			System.out.println("중복있음");
			jsonResult.put("status", false);
			jsonResult.put("message", "해당 아이디는 사용 불가능합니다");
		}
		return jsonResult;
	}
	// 회원가입
	public String registerForm(HttpServletRequest request, HttpServletResponse response)throws Exception {
		return "/member/register.jsp";
	}
	public JSONObject register(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
		String jsonStr = in.readLine();
		System.out.println("jsonStr = " + jsonStr);

		JSONObject jsonMember = new JSONObject(jsonStr);

		SimpleDateFormat now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = now.format(System.currentTimeMillis());

		String uid = (String) jsonMember.get("uid");
		String pwd = (String) jsonMember.get("pwd");
		String name = (String) jsonMember.get("nickname");
		String email = (String) jsonMember.get("email");

		JSONObject jsonResult = new JSONObject();
		MemberDAO memberDAO = new MemberDAO();
		System.out.println("회원가입 시도");
		try {
			memberDAO.addMember(new MemberBean(uid, pwd, name, email, nowTime));
			System.out.println("회원가입 성공");
			jsonResult.put("status", true);
			jsonResult.put("url", "/DZ_MultiChat/login.jsp");
			jsonResult.put("message", "해당 아이디는 사용가능합니다");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 실패");
			jsonResult.put("status", false);
			jsonResult.put("message", "해당아이디는  현재 사용중인 아이디 입니다 ");
		}
		return jsonResult;
	}
	//아이디 찾기
	public String findUserId(HttpServletRequest request, HttpServletResponse response)throws Exception {
		return "/member/findUserId.jsp";
	}
	public JSONObject findId(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String email = request.getParameter("email");
		System.out.println(email);
		
		MemberDAO memberDAO = new MemberDAO();
		String uid = memberDAO.findUserId(email);
		JSONObject jsonResult = new JSONObject();
		if (uid == null) {
			System.out.println("아이디 없음");
			jsonResult.put("status", false);
			jsonResult.put("message", "에 해당하는 이메일이 없습니다");
		} else {
			System.out.println("아이디 있음");
			jsonResult.put("status", true);
			jsonResult.put("message", "아이디 : "+uid);
		}
		return jsonResult;
	}
	//비밀번호 찾기
	public String findUserPw(HttpServletRequest request, HttpServletResponse response)throws Exception {
		return "/member/findUserPw.jsp";
	}
	public JSONObject findPw(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String email = request.getParameter("email");
		String uid = request.getParameter("uid");
				
		MemberDAO memberDAO = new MemberDAO();
		String pwd = memberDAO.findUserPwd(email,uid);
		JSONObject jsonResult = new JSONObject();
				
		if (pwd!=null) {
			System.out.println("입력성공");
			jsonResult.put("status", true);
			jsonResult.put("message", "비밀번호 : "+pwd);
			
		} else {
			System.out.println("입력실패");
			jsonResult.put("status", false);
			jsonResult.put("message", "아이디 또는 이메일이 일치 하지 않습니다");
		}
		return jsonResult;
	}
	//회원정보 수정
	public String memberUpdateForm(HttpServletRequest request, HttpServletResponse response)throws Exception {
		return "/member/memberUpdate.jsp";
	}
	public JSONObject memberUpdate(HttpServletRequest request, HttpServletResponse response)throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
		String jsonStr = in.readLine();
		System.out.println("jsonStr = " + jsonStr);
		
		JSONObject jsonMember = new JSONObject(jsonStr);
		
		String id=(String)request.getSession().getAttribute("uid");
		String pwd = (String)jsonMember.get("pwd");
		String name = (String)jsonMember.get("nickname");
		String email = (String)jsonMember.get("email");
		System.out.println(id+" "+pwd+" "+name+" "+email+" ");
		JSONObject jsonResult = new JSONObject();
		MemberDAO memberDAO = new MemberDAO();
		System.out.println("회원수정 시도");
		try {
			memberDAO.updateMember(new MemberBean(id,pwd, name, email));
			System.out.println("회원수정 성공");
			jsonResult.put("status", true);
			jsonResult.put("url", "/DZ_MultiChat/home.jsp");
			jsonResult.put("message", "수정되었습니다");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원수정 실패");
			jsonResult.put("status", false);
			jsonResult.put("message", "수정 실패하였습니다 ");
		}
		
		return jsonResult;
	}
	//회원 정보 확인
	public String memberView(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String id=(String)request.getSession().getAttribute("uid");
		MemberDAO memberDAO = new MemberDAO();
		MemberBean memberBean = memberDAO.viewMember(id);
		request.setAttribute("memberBean", memberBean);
		memberDAO.close();
		
		return "/member/memberView.jsp";
	}

//	public void updateForm(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		try {
//			HttpSession session = request.getSession();
//
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/member/memberUpdate.jsp");
//			dispatcher.forward(request, response);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
//			String jsonStr = in.readLine();
//			System.out.println("jsonStr = " + jsonStr);
//			
//			JSONObject jsonMember = new JSONObject(jsonStr);
//			
//			HttpSession session = request.getSession();
//			
//			MemberDAO memberDAO = new MemberDAO();
//			String uid = jsonMember.getString("uid");
//			String pwd = jsonMember.getString("pwd");
//			String name = jsonMember.getString("name");
//			String email = jsonMember.getString("email");
//			MemberBean member = new MemberBean(uid, pwd, name,  email, "");
//			int count = memberDAO.updateMember(member);
//			JSONObject jsonResult = new JSONObject();
//			
//			if (count == 1) {
//				jsonResult.put("status", true);
//				jsonResult.put("message", "수정되었습니다");
//				session.setAttribute("session_member", member);
//			} else {
//				jsonResult.put("status", false);
//				jsonResult.put("message", "해당아이디는 현재 DB에 존재하지 않습니다");
//			}
//	         
//			PrintWriter out = response.getWriter();
//			out.println(jsonResult.toString());
//			
//	     } catch (Exception e) {
//	        e.printStackTrace();
//	     }
//	}
}
	
//	public void registerForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//			HttpSession session = request.getSession();
//
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/member/updateForm.jsp");
//			dispatcher.forward(request, response);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	public void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
//			String jsonStr = in.readLine();
//			System.out.println("jsonStr = " + jsonStr);
//			
//			JSONObject jsonMember = new JSONObject(jsonStr);
//			
//			HttpSession session = request.getSession();
//			
//			MemberDAO memberDAO = new MemberDAO();
//			String uid = jsonMember.getString("uid");
//			String pwd = jsonMember.getString("pwd");
//			String name = jsonMember.getString("name2");
//			String sex = jsonMember.getString("sex");
//			String address = jsonMember.getString("address");
//			String phone = jsonMember.getString("phone");
//			String email = jsonMember.getString("email");
//			Member member = new Member(uid, pwd, name, sex, address, phone, email, "", null);
//			int count = memberDAO.updateMember(member);
//			JSONObject jsonResult = new JSONObject();
//			
//			if (count == 1) {
//				jsonResult.put("status", true);
//				jsonResult.put("message", "수정되었습니다");
//				session.setAttribute("session_member", member);
//			} else {
//				jsonResult.put("status", false);
//				jsonResult.put("message", "해당아이디는 현재 DB에 존재하지 않습니다");
//			}
//	         
//			PrintWriter out = response.getWriter();
//			out.println(jsonResult.toString());
//			
//	     } catch (Exception e) {
//	        e.printStackTrace();
//	     }
//	}	
//}
