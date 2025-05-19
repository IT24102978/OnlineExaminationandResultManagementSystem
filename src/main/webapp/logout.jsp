<%
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect("adminLogin.jsp?error=Logged+out+successfully");
%>
