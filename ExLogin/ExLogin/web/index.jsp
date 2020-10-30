<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index</title>
    </head>
    <%
        Statement st = null;
        ResultSet rs = null;
    %>
    <body>
        <div class="container">
            <form action="index.jsp" method="post" name="form">
                <div class="form-group">
                    <br>
                  <input type="email" class="form-control" placeholder="Endereço de email" name="email" required>
                </div>
                <div class="form-group">
                  <input type="password" class="form-control" placeholder="Senha" name="senha" required>
                </div>
                <button type="submit" class="btn btn-outline-info">Enviar</button>
              </form>
            <%
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String nomeUsuario = "";
                String email2 = "";
                String senha2 = "";
                
                int i = 0;
                
                try{

                    st = new Conexao().conectar().createStatement();
                    rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '" + email + "' and senha = '" + senha + "'");
                    
                    while(rs.next()){
                    
                    senha2 = rs.getString(4); 
                    nomeUsuario = rs.getString(2);
                    email2 = rs.getString(3);
                    rs.last();
                    i = rs.getRow();
                }
                }catch(Exception e){
                    out.println(e);
                }
                if(email == null || senha == null){
                    out.println("Dados não foram preenchidos");
                } else{
                    if(i>0){
                        session.setAttribute("nomeUsuario", nomeUsuario);
                        response.sendRedirect("restrita.jsp");
                }
            }
            %>
        </div>
    </body>
</html>
