package ShowSite;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ShowCustomer")
public class S_Customer extends HttpServlet {

	private static final long serialVersionUID = 8259704377039656631L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//회원가입정보를 받아서 DB에 입력하고 입력된 결과를 화면에 출력하되
		//정상적으로 회원 가입되었으면 '회원가입 성공'을 출력하고 그렇지 않으면 '회원가입 실패'를 출력하도록 구현하시오.
		//post방식으로 넘어온 데이터의 한글깨짐 방지: request.setCharacterEncoding("UTF-8")
		request.setCharacterEncoding("UTF-8");
		
		String member_id = request.getParameter("member_id");
		String member_pw = request.getParameter("member_pw");
		String member_name = request.getParameter("member_name");
		String email = request.getParameter("email");
		
		Scustomer_DTO dto = new Scustomer_DTO();
		dto.setMember_id(member_id);
		dto.setMember_pw(member_pw);
		dto.setWriter(member_name);
		dto.setEmail(email);
		
		Scustomer_DAO dao = new Scustomer_DAO();
		Scustomer_DTO newDto = null;
		try {
			newDto = dao.Custumer(dto);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		if(newDto != null) {
			HttpSession session = request.getSession();
			session.removeAttribute("member");
			session.setAttribute("member", newDto);
			response.sendRedirect("/human/Showsite/main/S_Customaercenter.jsp");
		}else {
			String msg = "시스템 문제로 회원정보가 정상적으로 변경되지 못했습니다. 다음에 다시 변경해주세요.";
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("/human/main/book_update.jsp").forward(request, response);
		}
	}
}