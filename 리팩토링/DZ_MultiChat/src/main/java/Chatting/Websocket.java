package Chatting;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

// WebSocket의 호스트 주소 설정
//@ServerEndpoint("/websocket")
public class Websocket implements Serializable {
	// 접속 된 클라이언트 WebSocket session 관리 리스트
	private static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	Map<String, List> ChatMap = null;

	// WebSocket으로 브라우저가 접속하면 요청되는 함수
	@OnOpen
	public void handleOpen(Session userSession) {
		// 클라이언트가 접속하면 WebSocket세션을 리스트에 저장한다.
		sessionUsers.add(userSession);
		// 콘솔에 접속 로그를 출력한다.
		System.out.println("client is now connected...");
	}

	// WebSocket으로 메시지가 오면 요청되는 함수
	@OnMessage
	public void handleMessage(String message, Session userSession) {
		// message의 구조 : {userName: "홍길동", op : "특정기능", message:"안녕"}
		JSONObject jsonObject = new JSONObject(message);
		String sendMessage = jsonObject.getString("userName") + " : " + jsonObject.getString("message");

		// session관리 리스트에서 Session을 취득한다.
		sessionUsers.forEach(session -> {
			// 리스트에 있는 세션과 메시지를 보낸 세션이 같으면 메시지 송신할 필요없다.
			if (session == userSession) {
				return;
			}
			try {
				// 리스트에 있는 모든 세션(메시지 보낸 유저 제외)에 메시지를 보낸다. (형식: 유저명 => 메시지)
				session.getBasicRemote().sendText(sendMessage);
			} catch (IOException e) {
				// 에러가 발생하면 콘솔에 표시한다.
				e.printStackTrace();
			}
		});
	}

	// WebSocket과 브라우저가 접속이 끊기면 요청되는 함수
	@OnClose
	public void handleClose(Session userSession) {
		// session 리스트로 접속 끊은 세션을 제거한다.
		sessionUsers.remove(userSession);
		// 콘솔에 접속 끊김 로그를 출력한다.
		System.out.println("client is now disconnected...");
	}

	// WebSocket과 브라우저 간에 통신 에러가 발생하면 요청되는 함수.
	@OnError
	public void handleError(Throwable t) {
		// 콘솔에 에러를 표시한다.
		t.printStackTrace();
	}
}