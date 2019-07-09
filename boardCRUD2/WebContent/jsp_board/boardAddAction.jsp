<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<body>
<%
    /* *** ���� API ��� **************************************************************** 
        request.setCharacterEncoding() - request�ȿ� ����ִ� �Ű��������鿡 ���� ���ڵ� ����
        request.getParameter() - �Ű��������� ������ ���Ǵ� getter�ż���
        Connection - DB����� ���õ� ������ ������ ������ Ÿ��
        PreparedStatement - ����� DB�� ������ �����ϰ� �����Ҵ� ���Ǵ� ������ Ÿ��
        Class.forName() - �Ű������� �ԷµǴ� ���ڿ��� �����ͺ��̽��� ����� �� �ֵ��� �ʱ�ȭ ��Ű�� �޼���
        DriverManager.getConnection - �����ͺ��̽��� �����ϴ� �޼���, Connection��ü�� ������
    ********************************************************************************** */
    request.setCharacterEncoding("euc-kr");
    String boardPw = request.getParameter("boardPw");
    System.out.println("param boardPw:"+boardPw);
    String boardTitle = request.getParameter("boardTitle");
    System.out.println("param boardTitle:"+boardTitle);
    String boardContent = request.getParameter("boardContent");
    System.out.println("param boardContent:"+boardContent);
    String boardUser = request.getParameter("boardUser");
    System.out.println("param boardUser:"+boardUser);
    String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
    String dbUser = "root";
    String dbPw = "java0000";
    Connection connection = null;
    PreparedStatement statement = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
        statement = connection.prepareStatement(sql);
        statement.setString(1,boardPw);
        statement.setString(2,boardTitle);
        statement.setString(3,boardContent);
        statement.setString(4,boardUser);
        statement.executeUpdate(); // insert ������ ����
    
    //  ���� ������ boardList.jsp �������� �̵��ϴ� �ڵ� - boardList.jsp�������� ������ �ʾƼ� �ּ�ó�� �ص�    
      response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } catch(Exception e) {
        e.printStackTrace();
        out.print("�Է� ���� �߻�"); //  response.sendRedirect(request.getContextPath()+"/jsp_board/boardAddForm.jsp");
    } finally {
        try {statement.close();} catch(Exception e){}
        try {connection.close();} catch(Exception e){}
    }
%>
</body>
</html>


