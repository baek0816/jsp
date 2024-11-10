import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 사전 정의된 임의 값 설정
    private final String aid = "admin";       // 아이디
    private final String apw = "1234";        // 비밀번호
    private final String aname = "관리자";     // 이름

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // login.html에서 전송된 id와 pw 파라미터 가져오기
        String id = request.getParameter("id");
        String pw = request.getParameter("password");

        // 로그인 정보 대조
        if (aid.equals(id) && apw.equals(pw)) {
            // 로그인 성공 - 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("username", aname);  // 세션에 사용자 이름 저장

            // main.jsp로 리다이렉트 (이름을 함께 전달)
            response.sendRedirect("main.jsp");
        } else {
            // 로그인 실패 - login.html로 리다이렉트
            response.sendRedirect("login.html");
        }
    }
}
