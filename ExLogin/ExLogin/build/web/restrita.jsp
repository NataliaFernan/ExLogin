<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista</title>
    </head>
    <body>
        <%
            String nome = (String) session.getAttribute("nomeUsuario");
            if(nome == null){
                response.sendRedirect("index.jsp");
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Controle de usuarios</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarText">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>

          </ul>
          <span class="navbar-text">
                Bem vindo <%out.println(nome);%> 
                <a href="deslogar.jsp" class="btn btn-danger">Sair</a>
          </span>
        </div>
      </nav>
        <div class="container">
            
            <div class="row mt-4 mb-4">
                <button class="btn-info" data-toggle="modal" data-target="#exampleModal">Novo Usuário</button>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Digite um nome" aria-label="Search">
                    <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Buscar</button>
                </form>
            </div>
            
            <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Cod</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Email</th>
                    <th scope="col">Senha</th>
                    <th scope="col">Nível</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                        Statement st = null;
                        ResultSet rs = null;
                        String id_usuario = "";
                        String nome_usuario = "";
                        String email_usuario = "";
                        String senha_usuario = "";
                        String nivel_usuario = "";
                        
                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM pessoas");
                            while(rs.next()){
                    %>
                  <tr>
                    <th scope="row"><%= rs.getString(1) %></th>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                  </tr>
                  
                   <%
                                
                            }
                        }catch(Exception e){
                            out.println(e);
                        }
                        
                    %>
                  
                </tbody>
              </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </body>
</html>

<!-- Modal -->
<div class="modal" id="exampleModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <form action="usuarios.jsp" method="post">
      <div class="modal-body">
        <center><label>Nome:</label></center>
        <input type="text" name="nome" class="form-control" placeholder="Digite o nome" required>
        <center><label>Email:</label></center>
        <input type="text" name="email" class="form-control" placeholder="Digite o email" required>
        <center><label>Senha:</label></center>
        <input type="password" name="senha" class="form-control" placeholder="Digite a senha" required>
        <center><label>Tipo de cadastro:</label></center>
        <select class="custom-select" name="tipo" size="2">
            <option selected value="comum">Comum</option>
            <option value="Admin">Admin</option>
        </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Sair</button>
        <input type="submit" name="cadastrar" class="btn btn-primary" value="Cadastrar">
      </div>
      </form>
    </div>
  </div>
</div>

<%
    
    if (request.getParameter("btn-salvar") != null) {
        
    String nome_cadastro = request.getParameter("nome");
    String email_cadastro = request.getParameter("email");
    String senha_cadastro = request.getParameter("senha");
    String nivel_cadastro = request.getParameter("nivel");
            
            try{
                
                st = new Conexao().conectar().createStatement();
                
                rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '"+ email_cadastro +"'");
                while(rs.next()){
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("<script>alert('Usuario ja cadastrado')</script>");
                            return;
                        }
                }
                
                st.executeUpdate("INSERT INTO pessoas (nome, email, senha, nivel) VALUES ('"+nome_cadastro+"','"+email_cadastro+"','"+senha_cadastro+"','"+nivel_cadastro+"')");
                
            }catch(Exception e){
                out.println(e);
            }
            
        }

%>