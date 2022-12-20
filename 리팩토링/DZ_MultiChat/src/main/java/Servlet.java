import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/"*)
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	Map<String, Action> actionMap = new HashMap<>();
	//클래스명 맵
	Map<String, Object> className2ObjectMap = new HashMap<>();
	//객체 맵
	Map<String, Object> objectMap = new HashMap<>();
	//메서드 맵 
	Map<String, Method> methodMap = new HashMap<>();
	String contextPath;
	
   
	public Servlet() {
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init 실행");
		super.init(config);
		
		contextPath = config.getServletContext().getContextPath();
		
		String actionNames = config.getInitParameter("actionNames");
		actionNames = actionNames.trim();
		
		try {
		for (String line : actionNames.split("\n")) {
			line = line.trim();
			
			String [] actionInfo = line.split(":");
			//클래스를 로딩한다
			Class<?> cls = Class.forName(actionInfo[1]);
			System.out.println(Arrays.toString(actionInfo));
			//클래스명이 존재하는지 확인한다 
			if (!className2ObjectMap.containsKey(actionInfo[1])) {
				//클래스를 이용하여 객체를 생성한다
				Object object = cls.getDeclaredConstructor().newInstance();
				
				//생성된 객체를 클래스 명으로 해서 맵에 추가함 
				className2ObjectMap.put(actionInfo[1], object);
				//생성된 객체를 URL 명으로 해서 맵에 추가함
				objectMap.put(actionInfo[0], object);
			} else {
				
				//클래스명으로 해서 생성된 객체를 URL 명으로 해서 맵에 추가함
				objectMap.put(actionInfo[0], className2ObjectMap.get(actionInfo[1]));
			}
			Method method = cls.getMethod(actionInfo[2], HttpServletRequest.class, HttpServletResponse.class);
			methodMap.put(actionInfo[0], method);
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doget 실행");
		String path = request.getRequestURI();
		path = path.substring(contextPath.length());
		System.out.println(path);
		Object obj = objectMap.get(path);
		Method method = methodMap.get(path);
		System.out.println(obj);
		System.out.println(method);
		if (obj != null && method != null) {
			//action.execute(request, response);
			try {
				//invoke 질문
				System.out.println("invoke 실행");
				Object ret = method.invoke(obj, request, response);
				System.out.println("ret호출"+ret);
				if (ret.getClass().equals(String.class)) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF" + (String) ret);
					dispatcher.forward(request, response);
				} else if (ret.getClass().equals(JSONObject.class)) {
					System.out.println("ret 호출 실패");
					JSONObject jsonResult = (JSONObject) ret;
					PrintWriter out = response.getWriter();
					out.println(jsonResult == null ? "{status:false}" : jsonResult.toString());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
/*	
URL => 어떤작업실행(메서드, 함수)
class명,
메소드 호출 방법
1. 일반 메서드 : obj.method()
2. 정적 메서드 : ClassName.method()
*/	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
