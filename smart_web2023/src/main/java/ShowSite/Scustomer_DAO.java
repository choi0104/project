package ShowSite;

import java.sql.SQLException;

public class Scustomer_DAO extends S_DBconnection{

	public Scustomer_DTO Custumer(Scustomer_DTO dto) throws SQLException{
		Scustomer_DTO newDto = null;
		String sql = "select s_idx from tb_show where member_id=? and member_pw=?";
		S_pstmt = S_conn.prepareStatement(sql);
		S_pstmt.setString(1, dto.getMember_id());
		S_pstmt.setString(2, dto.getMember_pw());
		if(S_pstmt.executeUpdate() == 1) {//회원정보 엽데이트 성공
			newDto = updateCustumer(dto);
		}
		return newDto;
	}

	public Scustomer_DTO updateCustumer(Scustomer_DTO dto) throws SQLException{
		Scustomer_DTO newDto = null;
		String sql = "insert into tb_show (s_idx, member_id, member_pw, writer, email, content)"
				+ " values(scustomercenter_seq.nextval, ?,?,?,?,?)";
		S_pstmt = S_conn.prepareStatement(sql);
		S_pstmt.setString(1, dto.getMember_id());
		S_pstmt.setString(2, dto.getMember_pw());
		S_pstmt.setString(3, dto.getWriter());
		S_pstmt.setString(3, dto.getEmail());
		S_pstmt.setString(5, dto.getContent());
		return newDto;
	}

}
